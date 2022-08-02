vim.g.tokyonight_style = "night"
vim.g.tokyonight_colors = { border = "#292E42" }

local colors = require("kanagawa.colors").setup()
require("kanagawa").setup({
  overrides = {
    VertSplit = { fg = colors.sumiInk4, bg = colors.bg },
  }
})

vim.cmd.colorscheme('kanagawa')
