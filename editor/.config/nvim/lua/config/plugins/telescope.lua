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
    "barrett-ruth/telescope-http.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "kkharji/sqlite.lua", -- Needed for telescope-frecency
  },
}

function M.config()
  local telescope = require("telescope")
  local lga_actions = require("telescope-live-grep-args.actions")
  local themes = require("telescope.themes")
  local actions = require("telescope.actions")
  local action_layout = require("telescope.actions.layout")
  local previewers = require("telescope.previewers")
  local trouble = require("trouble.providers.telescope")
  local wk = require("which-key")

  local MAX_PREVIEW_FILE_SIZE = 100000

  local previewer_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)

    -- Don't preview binary files
    require("plenary.job")
      :new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            -- Don't preview large files
            vim.loop.fs_stat(filepath, function(_, stat)
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
          ["<c-t>"] = trouble.open_with_trouble,
          ["<M-p>"] = action_layout.toggle_preview,
        },
        n = {
          ["<M-p>"] = action_layout.toggle_preview,
          ["<c-t>"] = trouble.open_with_trouble,
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
    },
  })

  local files_theme = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
    layout_config = {
      anchor = "N",
      height = 0.5,
    },
  })

  -- Use native zf for better performance.
  -- This will override the default file and generic sorters.
  telescope.load_extension("zf-native")

  telescope.load_extension("recent_files")
  telescope.load_extension("advanced_git_search")
  telescope.load_extension("frecency")

  local function buffers()
    require("telescope.builtin").buffers()
  end

  local function find_files(opts)
    opts = vim.tbl_extend("force", {
      find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" },
      theme = files_theme,
    }, files_theme, opts or {})
    require("telescope.builtin").find_files(opts)
  end

  local function git_files(opts)
    opts = vim.tbl_extend("force", files_theme, opts or {})
    local ok = pcall(require("telescope.builtin").git_files, files_theme)
    -- Fallback to find_files() if it can't find .git directory
    if not ok then
      find_files()
    end
  end

  local function live_grep()
    local opts = {}
    require("telescope.builtin").live_grep(opts)
  end

  local function live_grep_args()
    require("telescope").extensions.live_grep_args.live_grep_args()
  end

  local function resume()
    local opts = {}
    require("telescope.builtin").resume(opts)
  end

  local function quickfix()
    local opts = {}
    require("telescope.builtin").quickfix(opts)
  end

  local function lsp_document_symbols()
    local opts = {}
    require("telescope.builtin").lsp_document_symbols(opts)
  end

  local function lsp_workspace_symbols()
    local opts = {}
    require("telescope.builtin").lsp_workspace_symbols(opts)
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

  local function treesitter()
    local opts = {}
    require("telescope.builtin").treesitter(opts)
  end

  local function command_history()
    local opts = {}
    require("telescope.builtin").command_history(opts)
  end

  local function help_tags()
    local opts = {}
    require("telescope.builtin").help_tags(opts)
  end

  local function jumplist()
    local opts = {}
    require("telescope.builtin").jumplist(opts)
  end

  local function vim_options()
    local opts = {}
    require("telescope.builtin").vim_options(opts)
  end

  local function keymaps()
    local opts = {}
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

  wk.register({
    name = "Telescope",
    prefix = "<leader>t",
    b = { buffers, "Search buffers" },
    P = { find_files, "Search files" },
    p = { git_files, "Search git files" },
    g = { live_grep, "Search live grep" },
    a = { live_grep_args, "Search live grep with args" },
    r = { resume, "Resume search" },
    q = { quickfix, "Search quickfix" },
    t = { lsp_document_symbols, "Search LSP document symbols" },
    T = { lsp_workspace_symbols, "Search LSP workspace symbols" },
    R = { lsp_references, "Search LSP references" },
    s = { treesitter, "Search treesitter" },
    h = { command_history, "Search command history" },
    H = { help_tags, "Search help tags" },
    j = { jumplist, "Search jumplist" },
    o = { vim_options, "Search vim options" },
    k = { keymaps, "Search keymaps" },
    c = { find_config_files, "Search config files" },
    C = { colorscheme, "Search colorschemes" },
    d = { buffer_diagnostics, "Search buffer diagnostics" },
    D = { workspace_diagnostics, "Search workspace diagnostics" },
    f = { telescope.extensions.recent_files.pick, "Search recent files" },
    F = { telescope.extensions.frecency.frecency, "Search 'frecently' edited files" },
    G = {
      name = "Git",
      c = { git_commits, "Search git commits" },
      b = { git_branches, "Search git branches" },
      B = { git_diff_branch_file, "Search git branches (open diff)" },
      L = { git_diff_commit_line, "Search git commits for selected lines" },
      f = { git_diff_commit_file, "Search git commits for current file" },
      l = { git_search_log_content, "Search git log content" },
      r = { git_checkout_reflog, "Search git reflog entries" },
    },
  })
end

return M
