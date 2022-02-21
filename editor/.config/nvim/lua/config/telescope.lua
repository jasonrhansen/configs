local telescope = require("telescope")
local themes = require("telescope.themes")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local previewers = require("telescope.previewers")
local trouble = require("trouble.providers.telescope")
local wk = require("which-key")

local M = {}

local previewer_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)

  -- Don't preview binary files
  require("plenary.job"):new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
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
})

-- Use native zf for better performance.
-- This will override the default file and generic sorters.
telescope.load_extension("zf-native")

function M.buffers()
  require("telescope.builtin").buffers()
end

function M.find_files()
  local opts = {
    find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" },
  }
  require("telescope.builtin").find_files(opts)
end

function M.git_files()
  local opts = {}
  local ok = pcall(require("telescope.builtin").git_files, opts)
  -- Fallback to find_files() if it can't find .git directory
  if not ok then
    M.find_files()
  end
end

function M.live_grep()
  local opts = {}
  require("telescope.builtin").live_grep(opts)
end

function M.resume()
  local opts = {}
  require("telescope.builtin").resume(opts)
end

function M.quickfix()
  local opts = {}
  require("telescope.builtin").quickfix(opts)
end

function M.lsp_document_symbols()
  local opts = {}
  require("telescope.builtin").lsp_document_symbols(opts)
end

function M.lsp_workspace_symbols()
  local opts = {}
  require("telescope.builtin").lsp_workspace_symbols(opts)
end

function M.lsp_references()
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

function M.lsp_code_actions()
  local opts = themes.get_dropdown({
    border = true,
    previewer = false,
    shorten_path = false,
  })

  require("telescope.builtin").lsp_code_actions(opts)
end

function M.lsp_treesitter()
  local opts = {}
  require("telescope.builtin").treesitter(opts)
end

function M.command_history()
  local opts = {}
  require("telescope.builtin").command_history(opts)
end

function M.help_tags()
  local opts = {}
  require("telescope.builtin").help_tags(opts)
end

function M.jumplist()
  local opts = {}
  require("telescope.builtin").jumplist(opts)
end

function M.vim_options()
  local opts = {}
  require("telescope.builtin").vim_options(opts)
end

function M.keymaps()
  local opts = {}
  require("telescope.builtin").keymaps(opts)
end

function M.colorscheme()
  local opts = themes.get_dropdown({
    border = true,
    previewer = false,
    shorten_path = false,
  })
  require("telescope.builtin").colorscheme(opts)
end

function M.git_commits()
  local opts = {}
  require("telescope.builtin").git_commits(opts)
end

function M.git_branches()
  local opts = {}
  require("telescope.builtin").git_branches(opts)
end

-- Find my config files
function M.find_config_files()
  local opts = {
    cwd = "~/configs",
    find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" },
  }
  require("telescope.builtin").find_files(opts)
end

-- Normal mode keymaps to call functions in 'telescope.builtin'
local keymaps = {
  name = "Telescope",
  b = { "buffers()", "Search buffers" },
  P = { "find_files()", "Search files" },
  p = { "git_files()", "Search git files" },
  g = { "live_grep()", "Search live grep" },
  r = { "resume()", "Resume search" },
  q = { "quickfix()", "Search quickfix" },
  t = { "lsp_document_symbols()", "Search LSP document symbols" },
  T = { "lsp_workspace_symbols()", "Search LSP workspace symbols" },
  R = { "lsp_references()", "Search LSP references" },
  a = { "lsp_code_actions()", "Search code actions" },
  s = { "treesitter()", "Search treesitter" },
  h = { "command_history()", "Search command history" },
  H = { "help_tags()", "Search help tags" },
  j = { "jumplist()", "Search jumplist" },
  o = { "vim_options()", "Search vim options" },
  k = { "keymaps()", "Search keymaps" },
  c = { "find_config_files()", "Search config files" },
  C = { "colorscheme()", "Search colorschemes" },
  G = {
    name = "Git",
    c = { "git_commits()", "Search git commits" },
    b = { "git_branches()", "Search git branches" },
  }
}

local function to_telescope_keymaps(table)
  return vim.tbl_map(function(keymap)
    if (type(keymap) ~= "table") then
      return keymap
    elseif keymap["name"] ~= nil then
      return to_telescope_keymaps(keymap)
    else
      return { "<cmd>lua require('config.telescope')." .. keymap[1] .. "<cr>", keymap[2] }
    end
  end, table)
end

keymaps = to_telescope_keymaps(keymaps)

-- Register keymaps with whick-key
wk.register(keymaps, { prefix = "<leader>t" })

-- SearchSession defined in rmagatti/session-lens
wk.register({ ["<leader>tS"] = { "<cmd>SearchSession<cr>", "Search sessions" } })

return M
