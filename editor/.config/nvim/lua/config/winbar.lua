vim.opt_global.winbar = nil

local function set_winbar(highlight)
  if vim.opt.filetype:get() ~= '' and vim.opt.buftype:get() == '' then
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
