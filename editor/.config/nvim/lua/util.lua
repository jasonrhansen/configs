local M = {}

M.pick_window = function(func_or_cmd)
  return function()
    local buf = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local picked_win = require("window-picker").pick_window()

    if picked_win and picked_win ~= vim.api.nvim_get_current_win() then
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

function M.require(module_name)
  -- Remove cached module so config can be reloaded without restarting neovim
  package.loaded[module_name] = nil

  require(module_name)
end

function M.file_size(buf)
  buf = buf or 0
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  return ok and stats and stats.size
end

function M.is_large_file(buf, large_file_size)
  local file_size = M.file_size(buf)
  large_file_size = large_file_size or (1000 * 1024)
  return file_size and file_size > large_file_size
end

function M.is_ssh_session()
  return vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil
end

function M.copy_to_clipboard(text)
  vim.fn.setreg("+", text)
end

function M.configure_buffer_for_large_file(bufnr)
  vim.opt_local.foldmethod = "manual"
  vim.opt_local.statuscolumn = ""
  vim.opt_local.conceallevel = 0
  vim.cmd("NoMatchParen")
  vim.cmd("IBLDisable")
  vim.cmd("TSContextDisable")
  vim.diagnostic.enable(false, { bufnr = bufnr })
end

return M
