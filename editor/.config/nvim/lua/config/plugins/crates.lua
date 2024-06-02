-- Help manage crates.io versions
local M = {
  "Saecki/crates.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
  require("crates").setup({
    lsp = {
      enabled = true,
      on_attach = function(client, buffer)
        require('config.plugins.lsp').attach(client, buffer)
      end,
      actions = true,
      completion = true,
      hover = true,
    }
  })
end

return M
