return {
  "xzbdmw/colorful-menu.nvim",
  config = function()
    require("colorful-menu").setup({
      ls = {
        fallback = false,
      }
    })
  end,
}
