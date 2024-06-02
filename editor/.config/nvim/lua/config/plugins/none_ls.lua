-- Inject LSP diagnostics, code actions, and more via Lua
local M = {
  "nvimtools/none-ls.nvim", -- Community fork of jose-elias-alvarez/null-ls.nvim
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  local null_ls = require("null-ls")
  null_ls.setup({
    should_attach = function(bufnr)
      return not require("util").is_large_file(bufnr)
    end,
    on_attach = function(client, buffer)
      require("config.plugins.lsp").attach(client, buffer)
    end,
    sources = {
      null_ls.builtins.formatting.rubocop,
    },
  })
end

return M
