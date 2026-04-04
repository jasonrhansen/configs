return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer or range",
    },
  },
  opts = {
    formatters = {
      stylua = {
        args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      ruby = { "rubocop" },
      erb = { "erb_format" },
      go = { "goimports", "gofmt" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascript = { "prettier" },
      -- Fallback for everything else to ensure they are available
      ["_"] = { "trim_whitespace", "trim_newlines" },
    },
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      local whitelist = { "rust", "go" }

      -- Always apply global sanitization
      local formatters = { "trim_whitespace", "trim_newlines" }

      -- Add language-specific formatter ONLY if whitelisted
      if vim.tbl_contains(whitelist, ft) then
        local conform = require("conform")
        ---@diagnostic disable-next-line: param-type-mismatch
        for _, f in ipairs(conform.formatters_by_ft[ft] or {}) do
          table.insert(formatters, f)
        end
      end

      return {
        timeout_ms = 500,
        lsp_format = "fallback",
        formatters = formatters,
      }
    end,
  },
}
