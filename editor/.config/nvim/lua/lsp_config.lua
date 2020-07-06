local lsp = require 'nvim_lsp'
local lsp_status = require 'lsp-status'

local attach = function(client)
  lsp_status.on_attach(client)

  local mapper = function(mode, key, result)
    vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
  end

  mapper('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  mapper('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

  mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  mapper('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>')

  mapper('n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>')

  mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

  mapper('n', '<expr><c-space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

  mapper('n', '[g]', ':PrevDiagnostic<CR>')
  mapper('n', ']g', ':NextDiagnostic<CR>')

  mapper('n', '<leader>sl', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
end

lsp.util.default_config = vim.tbl_extend(
  "force",
  lsp.util.default_config,
  {
    on_attach = attach
  }
)

-- Language server configs
local configs = {
  bashls = {},
  ccls = {},
  clangd = {},
  cmake = {},
  cssls = {},
  dockerls = {},
  ghcide = {},
  gopls = {},
  html = {},
  intelephense = {},
  jsonls = {},
  pyls = {},
  rust_analyzer = {},
  solargraph = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          enable = true,
          globals = {
            "vim", "Color", "c", "Group", "g", "s", "describe", "it", "before_each", "after_each"
          },
        },
      },
    }
  },
  tsserver = {},
  vimls = {},
  yamlls = {},
}

-- Inititialize all language servers
for name, config in pairs(configs) do
  -- Add lsp_status capabilities
  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

  lsp[name].setup(config)
end

lsp_status.register_progress()
