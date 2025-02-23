return {
  "saghen/blink.nvim",
  keys = {
    -- chartoggle
    {
      "z;",
      function()
        require("blink.chartoggle").toggle_char_eol(";")
      end,
      mode = { "n", "v" },
      desc = "Toggle ; at eol",
    },
    {
      "z,",
      function()
        require("blink.chartoggle").toggle_char_eol(",")
      end,
      mode = { "n", "v" },
      desc = "Toggle , at eol",
    },
  },
  -- all modules handle lazy loading internally
  lazy = false,
  opts = {
    chartoggle = { enabled = true },
    delimiters = { enabled = false },
    indent = { enabled = false },
    tree = { enabled = false },
  },
}
