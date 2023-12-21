-- Progress indicator
return {
  "j-hui/fidget.nvim",
  tag = "v1.0.0",
  opts = {
    progress = {
      display = {
        progress_icon = {
          pattern = "circle_halves",
          period = 1,
        },
      },
      ignore = {
        -- Because of integration with ts-node-action, every time the cursor position
        -- changes a null-ls notification is shown, which can be quite annoying, so ignore them.
        "null-ls",
      },
    },
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
}
