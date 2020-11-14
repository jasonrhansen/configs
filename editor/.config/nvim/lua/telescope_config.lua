local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- Close with esc in insert mode.
        ["<esc>"] = actions.close,
      },
    },
    -- Color devicons slow it down too much for large projects.
    color_devicons = false,
  }
}

-- Normal mode keymaps to call functions in 'telescope.builtin'
local keymaps = {
  tb = 'buffers()',
  tP = 'find_files{ find_command = { "rg", "-i", "--hidden", "--files", "-g", "!.git" }',
  tp = 'git_files()',
  tr = 'live_grep()',
  tq = 'quickfix()',
  tt = 'lsp_document_symbols()',
  tT = 'lsp_workspace_symbols()',
  tR = 'ls_references()',
  ta = 'ls_code_actions()',
  ts = 'treesitter()',
  th = 'command_history()',
  tH = 'help_tags()',
}

-- Add keybindings
for key, func in pairs(keymaps) do
  vim.fn.nvim_set_keymap('n', key, "<cmd>lua require'telescope.builtin'." .. func .. '<CR>', {noremap=true, silent=true})
end
