vim.o.winbar = " "

local ignore_filetypes = {
  "",
  "neo-tree",
}

local function set_winbar(highlight)
  local ignored_filetype = vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
  if ignored_filetype then
    return
  end

  if vim.bo.buftype ~= "" then
    return
  end

  local is_floating = vim.api.nvim_win_get_config(0).relative ~= ""
  if is_floating then
    vim.wo.winbar = nil
    return
  end

  vim.wo.winbar = "%#" .. highlight .. "#%=%m %f"
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = "jason-config",
  callback = function()
    set_winbar("Normal")
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = "jason-config",
  callback = function()
    set_winbar("Comment")
  end,
})
