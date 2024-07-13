-- Displays a popup with possible key bindings of the command you started typing
local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local wk = require("which-key")

  wk.setup({
    ---@type false | "classic" | "modern" | "helix"
    preset = "modern",
  })
end

return M
