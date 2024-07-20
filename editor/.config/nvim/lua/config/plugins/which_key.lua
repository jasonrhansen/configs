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
    -- Delay before showing the popup. Can be a number or a function that returns a number.
    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = function(ctx)
      return ctx.plugin and 0 or 500
    end,
    notify = true,
  })
end

return M
