local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '✗',
  warn_sign = '⚠',
  hint_sign = '',
  infor_sign = 'ⓘ ',
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
vim.cmd [[autocmd User CompeConfirmDone :Lspsaga signature_help]]

vim.api.nvim_set_keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', 'gs', '<cmd>Lspsaga signature_help<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<F2>', '<cmd>Lspsaga rename<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>pd', '<cmd>Lspsaga preview_definition<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '[g', 'cmd>Lspsaga diagnostic_jump_prev<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', ']g', '<cmd>Lspsaga diagnostic_jump_next<CR>', {noremap=true, silent=true})

vim.api.nvim_exec(
[[
  hi link TargetWord Normal
]], false)
