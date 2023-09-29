-- Adds indentation guides to all lines (including empty lines).
local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
}

function M.config()
  require("ibl").setup({
    enabled = false,
  })
end

return M
