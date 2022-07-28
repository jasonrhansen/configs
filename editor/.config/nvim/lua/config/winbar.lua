vim.opt_global.winbar = nil

local ignore_filetypes = {
  '',
  'neo-tree',
}

local function set_winbar(highlight)
  local ignored_filetype = vim.tbl_contains(ignore_filetypes, vim.opt.filetype:get())
  if ignored_filetype then return end

  local is_floating = vim.api.nvim_win_get_config(0).relative ~= ''
  if is_floating then return end

  if vim.opt.buftype:get() == '' then
    vim.opt_local.winbar = "%#" .. highlight .. "#%=%m %f"
  else
    vim.opt_local.winbar = nil
  end
end

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
  group = "vimrc",
  callback = function()
    set_winbar("Normal")
  end
})

vim.api.nvim_create_autocmd({"WinLeave"}, {
  group = "vimrc",
  callback = function()
    set_winbar("Comment")
  end
})
