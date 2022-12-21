local M = {
  "kosayoda/nvim-lightbulb",
  requires = "antoinemadec/FixCursorHold.nvim",
}

function M.config()
  -- Update lightbulb on cursor hold.
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = "jason-config",
    callback = function()
      require("nvim-lightbulb").update_lightbulb()
    end,
  })
end


return M
