-- Fuzzy finder
local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "smartpde/telescope-recent-files",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "aaronhallaert/ts-advanced-git-search.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
}

function M.config()
  local telescope = require("telescope")
  local lga_actions = require("telescope-live-grep-args.actions")
  local themes = require("telescope.themes")
  local actions = require("telescope.actions")
  local action_layout = require("telescope.actions.layout")
  local previewers = require("telescope.previewers")
  local trouble = require("trouble.sources.telescope")
  local wk = require("which-key")

  local MAX_PREVIEW_FILE_SIZE = 100000

  local previewer_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = tostring(vim.fn.expand(filepath))

    -- Don't preview binary files
    require("plenary.job")
      :new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            -- Don't preview large files
            vim.uv.fs_stat(filepath, function(_, stat)
              if not stat or stat.size > MAX_PREVIEW_FILE_SIZE then
                vim.schedule(function()
                  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "FILE TOO LARGE FOR PREVIEW" })
                end)
              else
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
              end
            end)
          else
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end,
      })
      :sync()
  end

  local pick_window_and_open = function(prompt_bufnr)
    -- Use nvim-window-picker to choose the window by dynamically attaching a function
    local action_set = require("telescope.actions.set")
    local action_state = require("telescope.actions.state")

    local current_picker = action_state.get_current_picker(prompt_bufnr)
    current_picker.get_selection_window = function(picker)
      local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
      -- Unbind after using so next instance of the picker acts normally
      picker.get_selection_window = nil
      return picked_window_id
    end

    return action_set.edit(prompt_bufnr, "edit")
  end

  telescope.setup({
    defaults = {
      winblend = 10,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
      },
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
      mappings = {
        i = {
          -- Close with esc in insert mode.
          ["<esc>"] = actions.close,
          ["<c-b>"] = actions.cycle_history_prev,
          ["<c-f>"] = actions.cycle_history_next,
          ["<c-t>"] = trouble.open,
          ["<M-p>"] = action_layout.toggle_preview,
          ["<c-w>"] = pick_window_and_open,
          ["<c-space>"] = function(prompt_bufnr)
            require("telescope.actions.generate").refine(prompt_bufnr, {
              prompt_to_prefix = true,
              sorter = false,
            })
          end,
        },
        n = {
          ["<M-p>"] = action_layout.toggle_preview,
          ["<c-t>"] = trouble.open,
          ["<c-w>"] = pick_window_and_open,
        },
      },
      color_devicons = true,
      file_previewer = previewers.vim_buffer_cat.new,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      qflist_previewer = previewers.vim_buffer_qflist.new,
      buffer_previewer_maker = previewer_maker,
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
      recent_files = {
        only_cwd = true,
      },
    },
  })

  local files_theme = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
    layout_config = {
      anchor = "N",
      width = { 0.3, min = 100 },
      height = { 0.6, min = 30 },
    },
  })

  -- Use native zf for better performance.
  -- This will override the default file and generic sorters.
  telescope.load_extension("zf-native")

  telescope.load_extension("recent_files")
  telescope.load_extension("advanced_git_search")

  local function buffers(opts)
    opts = vim.tbl_extend("force", files_theme, opts or {})
    require("telescope.builtin").buffers(opts)
  end

  local function find_files(opts)
    opts = vim.tbl_extend("force", {
      find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" },
      theme = files_theme,
    }, files_theme, opts or {})
    require("telescope.builtin").find_files(opts)
  end

  local function git_files(opts)
    opts = vim.tbl_extend("force", {
      show_untracked = true,
    }, files_theme, opts or {})
    local ok = pcall(require("telescope.builtin").git_files, opts)
    -- Fallback to find_files() if it can't find .git directory
    if not ok then
      find_files()
    end
  end

  local function recent_files(opts)
    opts = vim.tbl_extend("force", files_theme, opts or {})
    telescope.extensions.recent_files.pick(opts)
  end

  local function live_grep(opts)
    require("telescope.builtin").live_grep(opts)
  end

  local function live_grep_args()
    require("telescope").extensions.live_grep_args.live_grep_args()
  end

  local function resume(opts)
    require("telescope.builtin").resume(opts)
  end

  local function quickfix(opts)
    require("telescope.builtin").quickfix(opts)
  end

  local function lsp_document_symbols(opts)
    require("telescope.builtin").lsp_document_symbols(opts)
  end

  local function lsp_workspace_symbols(opts)
    require("telescope.builtin").lsp_workspace_symbols(opts)
  end

  local function treesitter_symbols(opts)
    require("telescope.builtin").treesitter(opts)
  end

  local function document_symbols(opts)
    local ok = pcall(lsp_document_symbols, opts)
    -- If no LSP client is available, use treesitter symbols.
    if not ok then
      treesitter_symbols(opts)
    end
  end

  local function lsp_references()
    local opts = {
      layout_strategy = "vertical",
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
      ignore_filename = false,
    }
    require("telescope.builtin").lsp_references(opts)
  end

  local function command_history(opts)
    require("telescope.builtin").command_history(opts)
  end

  local function help_tags(opts)
    require("telescope.builtin").help_tags(opts)
  end

  local function jumplist(opts)
    require("telescope.builtin").jumplist(opts)
  end

  local function vim_options(opts)
    require("telescope.builtin").vim_options(opts)
  end

  local function keymaps(opts)
    require("telescope.builtin").keymaps(opts)
  end

  local function colorscheme()
    local opts = themes.get_dropdown({
      border = true,
      previewer = false,
      shorten_path = false,
    })
    require("telescope.builtin").colorscheme(opts)
  end

  local function git_commits()
    local opts = {}
    require("telescope.builtin").git_commits(opts)
  end

  local function git_branches()
    local opts = {}
    require("telescope.builtin").git_branches(opts)
  end

  local function git_diff_branch_file()
    require("telescope").extensions.advanced_git_search.diff_branch_file()
  end

  local function git_diff_commit_line()
    require("telescope").extensions.advanced_git_search.diff_commit_line()
  end

  local function git_diff_commit_file()
    require("telescope").extensions.advanced_git_search.diff_commit_file()
  end

  local function git_search_log_content()
    require("telescope").extensions.advanced_git_search.search_log_content()
  end

  local function git_checkout_reflog()
    require("telescope").extensions.advanced_git_search.checkout_reflog()
  end

  -- Find my config files
  local function find_config_files()
    local opts = {
      cwd = "~/configs",
      find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" },
    }
    find_files(opts)
  end
  local function buffer_diagnostics()
    local opts = {
      bufnr = 0,
    }
    require("telescope.builtin").diagnostics(opts)
  end

  local function workspace_diagnostics()
    local opts = {}
    require("telescope.builtin").diagnostics(opts)
  end

  wk.add({
    { "<leader>f", group = "Find with Telescope" },
    { "<leader>fb", buffers, desc = "Search buffers" },
    { "<leader>fP", find_files, desc = "Search files" },
    { "<leader>fp", git_files, desc = "Search git files" },
    { "<leader>fg", live_grep, desc = "Search live grep" },
    { "<leader>fa", live_grep_args, desc = "Search live grep with args" },
    { "<leader>fr", resume, desc = "Resume search" },
    { "<leader>fq", quickfix, desc = "Search quickfix" },
    { "<leader>ff", recent_files, desc = "Search recent files" },
    { "<leader>fT", lsp_workspace_symbols, desc = "Search LSP workspace symbols" },
    { "<leader>fR", lsp_references, desc = "Search LSP references" },
    { "<leader>fs", document_symbols, desc = "Search document symbols" },
    { "<leader>fh", command_history, desc = "Search command history" },
    { "<leader>fH", help_tags, desc = "Search help tags" },
    { "<leader>fj", jumplist, desc = "Search jumplist" },
    { "<leader>fo", vim_options, desc = "Search vim options" },
    { "<leader>fk", keymaps, desc = "Search keymaps" },
    { "<leader>fc", find_config_files, desc = "Search config files" },
    { "<leader>fC", colorscheme, desc = "Search colorschemes" },
    { "<leader>fd", buffer_diagnostics, desc = "Search buffer diagnostics" },
    { "<leader>fD", workspace_diagnostics, desc = "Search workspace diagnostics" },
    { "<leader>fG", group = "Git" },
    { "<leader>fGc", git_commits, desc = "Search git commits" },
    { "<leader>fGb", git_branches, desc = "Search git branches" },
    { "<leader>fGB", git_diff_branch_file, desc = "Search git branches (open diff)" },
    { "<leader>fGL", git_diff_commit_line, desc = "Search git commits for selected lines" },
    { "<leader>fGf", git_diff_commit_file, desc = "Search git commits for current file" },
    { "<leader>fGl", git_search_log_content, desc = "Search git log content" },
    { "<leader>fGr", git_checkout_reflog, desc = "Search git reflog entries" },
  })
end

return M
