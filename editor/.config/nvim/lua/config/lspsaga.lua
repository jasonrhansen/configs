local lsp_config = require 'config.lsp'
local saga = require 'lspsaga'

saga.init_lsp_saga {
  code_action_icon = '💡',
  error_sign = lsp_config.sign_error,
  warn_sign = lsp_config.sign_warning,
  hint_sign = lsp_config.sign_hint,
  infor_sign = lsp_config.sign_information,
  max_preview_lines = 20,
  finder_action_keys = {
    open = { 'o', '<CR>' }, vsplit = 'v', split = 's', quit = { 'q', '<Esc>' }, scroll_down = '<C-f>', scroll_up = '<C-b>'
  },
  code_action_keys = {
     quit = { 'q', '<Esc>' }, exec = '<CR>'
  },
  rename_action_keys = {
    quit = { '<C-c>', '<Esc>' }, exec = '<CR>'
  },
}

-- Automatically show signature help when completion selected in compe.
vim.cmd [[augroup vimrc]]
vim.cmd [[autocmd User CompeConfirmDone :Lspsaga signature_help]]
vim.cmd [[augroup END]]

-- Normal mode keymaps
local normal_keymaps = {
  gh = 'Lspsaga lsp_finder',
  K = 'Lspsaga hover_doc',
  ['<C-k>'] = 'Lspsaga signature_help',
  ['<C-f>'] = 'lua require("lspsaga.action").smart_scroll_with_saga(1)',
  ['<C-b>'] = 'lua require("lspsaga.action").smart_scroll_with_saga(-1)',
  ['<leader>a'] = 'Lspsaga code_action',
  ['<leader>rn'] = 'Lspsaga rename',
  ['<F2>'] = 'Lspsaga rename',
  ['<leader>pd'] = 'Lspsaga preview_definition',
  ['<leader>d'] = 'Lspsaga show_line_diagnostics',
  ['<leader>cd'] = 'Lspsaga show_cursor_diagnostics',
  ['[g'] = 'Lspsaga diagnostic_jump_prev',
  [']g'] = 'Lspsaga diagnostic_jump_next',
}
for key, expression in pairs(normal_keymaps) do
  vim.api.nvim_set_keymap('n', key, '<cmd>' .. expression .. '<CR>', {noremap=true, silent=true})
end

vim.api.nvim_set_keymap('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', {noremap=true, silent=true})

vim.api.nvim_exec(
[[
  hi link TargetWord Normal
  hi LspSagaDiagnosticBorder guifg=#6699cc
  hi LspSagaDiagnosticTruncateLine guifg=#6699cc
  hi LspSagaDiagnosticHeader gui=bold guifg=#e8e8d3
]], false)
