vim.g.tokyonight_style = "night"
vim.g.tokyonight_colors = { border = "#292E42" }

require("kanagawa").setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
})
vim.cmd.colorscheme("kanagawa")
