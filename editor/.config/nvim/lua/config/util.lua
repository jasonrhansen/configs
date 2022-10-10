local M = {}

M.pick_window_and_do = function(func)
  local buf = vim.api.nvim_get_current_buf();
  local cursor = vim.api.nvim_win_get_cursor(0);
  local picked_win = require('window-picker').pick_window()
  if picked_win then
    vim.api.nvim_set_current_win(picked_win)
    vim.api.nvim_set_current_buf(buf)
    vim.api.nvim_win_set_cursor(picked_win, cursor)
  else
    vim.cmd.vsplit()
  end
  func()
end

return M
