-- Bridges mason.nvim with the null-ls plugin - making it easier to use both plugins together
return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    require("mason-null-ls").setup({
      ensure_installed = {
        "prettierd",
        "stylua",
        "sql_formatter",
        -- python formatter
        "black",
      },
      automatic_installation = false,
      automatic_setup = true,
      handlers = {
        stylua = function()
          null_ls.register(null_ls.builtins.formatting.stylua.with({
            args = { "-s", "--indent-type", "Spaces", "--indent-width", "2", "-" },
          }))
        end,
      },
    })
  end,
}
