-- Automatically install LSPs to stdpath for neovim
local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
}

function M.config()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "angularls",
      "bashls",
      "cssls",
      "dockerls",
      "graphql",
      "html",
      "intelephense",
      "jsonls",
      "lemminx",
      "pyright",
      "lua_ls",
      "sqlls",
      "tsserver",
      "vimls",
      "yamlls",
    },
  })
end

return M
