local M = {}

M.pick_window = function(func_or_cmd)
  return function()
    local buf = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local picked_win = require("window-picker").pick_window()
    if picked_win then
      vim.api.nvim_set_current_win(picked_win)
      vim.api.nvim_set_current_buf(buf)
      vim.api.nvim_win_set_cursor(picked_win, cursor)
    else
      vim.cmd.vsplit()
    end

    if type(func_or_cmd) == "function" then
      func_or_cmd()
    elseif type(func_or_cmd) == "string" then
      vim.cmd(func_or_cmd)
    end
  end
end

return M
