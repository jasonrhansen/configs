local M = {}

function M.normal_windows_in_current_tab()
  local tab_wins = vim.api.nvim_tabpage_list_wins(0)
  local normal_wins = {}
  for _, win in ipairs(tab_wins) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative == "" and config.focusable then
      table.insert(normal_wins, win)
    end
  end

  return normal_wins
end

function M.pick_window(func_or_cmd)
  return function()
    local normal_wins = M.normal_windows_in_current_tab()
    local current_win = vim.api.nvim_get_current_win()
    local current_buf = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local picked_win

    if #normal_wins == 1 then
      vim.cmd.vsplit()
    elseif #normal_wins == 2 then
      for _, win in ipairs(normal_wins) do
        if win ~= current_win then
          picked_win = win
          break
        end
      end
    else
      picked_win = Snacks.picker.util.pick_win()
    end

    if picked_win and picked_win ~= current_win then
      -- Move the buffer and cursor to the selected window
      vim.api.nvim_set_current_win(picked_win)
      vim.api.nvim_win_set_buf(picked_win, current_buf)
      vim.api.nvim_win_set_cursor(picked_win, cursor)
    end

    vim.schedule(function()
      if type(func_or_cmd) == "function" then
        func_or_cmd()
      elseif type(func_or_cmd) == "string" then
        vim.cmd(func_or_cmd)
      end
    end)
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

M.get_project_root = function()
  local root = vim.fs.root(0, { ".git", "lua", "Cargo.toml", "package.json" })
  return root or vim.uv.cwd()
end

M.set_project_root = function()
  local root = M.get_project_root()
  if root then
    vim.api.nvim_set_current_dir(root)
    print("CWD set to: " .. root)
  else
    print("Couldn't get project root dir.")
  end
end

return M
