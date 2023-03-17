return {
  "folke/tokyonight.nvim",
  lazy = true,
  config = function()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_colors = { border = "#292E42" }
  end,
}
