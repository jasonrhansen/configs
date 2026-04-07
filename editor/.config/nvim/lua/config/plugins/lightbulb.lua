local M = {
  "kosayoda/nvim-lightbulb",
}

function M.config()
  local lightbulb = require("nvim-lightbulb")

  lightbulb.setup({
    autocmd = { enabled = false },
    sign = { enabled = true, priority = 10 },
    float = { enabled = false },
  })

  vim.api.nvim_create_autocmd({ "LspTokenUpdate", "CursorMoved", "CursorMovedI" }, {
    group = vim.api.nvim_create_augroup("jason-lightbulb", { clear = true }),
    callback = function()
      lightbulb.update_lightbulb()
    end,
  })
end

return M
