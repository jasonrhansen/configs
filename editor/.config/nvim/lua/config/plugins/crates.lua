-- Help manage crates.io versions
local M = {
  "Saecki/crates.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  require("crates").setup({
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    }
  })
end

return M
