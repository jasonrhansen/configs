local telescope = require("telescope")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local trouble = require("trouble.providers.telescope")
local wk = require("which-key")

telescope.setup {
  defaults = {
    winblend = 10,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
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
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
      },
    },
    color_devicons = true,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
  }
}

-- Use native fzy for better performance.
-- This will override the default file and generic sorters.
telescope.load_extension('fzy_native')

-- Normal mode keymaps to call functions in 'telescope.builtin'
local keymaps = {
  b = {"buffers()", "Search buffers"},
  P = {"find_files({find_commankd = {'rg', '-i', '--hidden', '--files', '-g', '!.git'}})", "Search files"},
  p = {"git_files()", "Search git files"},
  g = {"live_grep()", "Search live grep"},
  r = {"grep_string{ shorten_path = true, word_match = '-w', only_sort_text = true, search = ''}", "Search grep string"},
  q = {"quickfix()", "Search quickfix"},
  t = {"lsp_document_symbols()", "Search LSP document symbols"},
  T = {"lsp_workspace_symbols()", "Search LSP workspace symbols"},
  R = {"lsp_references()", "Search LSP references"},
  a = {"lsp_code_actions()", "Search code actions"},
  s = {"treesitter()", "Search treesitter"},
  h = {"command_history()", "Search command history"},
  H = {"help_tags()", "Search help tags"},

  -- Find my config files
  c = {"find_files({cwd = '~/configs', find_command = {'rg', '-i', '--hidden', '--files', '-g', '!.git'}})", "Search config files"},
}

keymaps = vim.tbl_map(function (keymap)
  return {"<cmd>lua require'telescope.builtin'." .. keymap[1] .. "<cr>", keymap[2]}
end, keymaps)

keymaps.name = "Telescope"

-- Register keymaps with whick-key
wk.register(keymaps, { prefix = "<leader>t" })

-- SearchSession defined in rmagatti/session-lens
wk.register({["<leader>tS"] = {"<cmd>SearchSession<cr>", "Search sessions"}})
