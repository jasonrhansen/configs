return {
  "j-hui/fidget.nvim",
  tag = "v1.6.1",
  opts = {
    progress = {
      display = {
        progress_icon = {
          pattern = "circle_halves",
          period = 1,
        },
        group_style = "Title",
      },
    },
    notification = {
      window = {
        winblend = 0,
        border = "none",
        relative = "editor",
      },
    },
    integration = {
      ["nvim-tree"] = { enable = true },
      ["xcodebuild-nvim"] = { enable = true },
    },
  },
}
