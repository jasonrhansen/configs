local telescope = require("telescope")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")

telescope.setup {
  defaults = {
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
    prompt_position = "top",
    sorting_strategy = "ascending",
    mappings = {
      i = {
        -- Close with esc in insert mode.
        ["<esc>"] = actions.close,
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
  tb = "buffers()",
  tP = "find_files({find_command = {'rg', '-i', '--hidden', '--files', '-g', '!.git'}})",
  tp = "git_files()",
  tg = "live_grep()",
  tG = "git_commits()",
  tr = "grep_string{ shorten_path = true, word_match = '-w', only_sort_text = true, search = ''}",
  tq = "quickfix()",
  tt = "lsp_document_symbols()",
  tT = "lsp_workspace_symbols()",
  tR = "ls_references()",
  ta = "ls_code_actions()",
  ts = "treesitter()",
  th = "command_history()",
  tH = "help_tags()",

  -- Find my config files
  tc = "find_files({cwd = '~/configs', find_command = {'rg', '-i', '--hidden', '--files', '-g', '!.git'}})",
}

-- Add keybindings
for key, func in pairs(keymaps) do
  vim.api.nvim_set_keymap("n", key, "<cmd>lua require'telescope.builtin'." .. func .. "<CR>", {noremap=true, silent=true})
end
