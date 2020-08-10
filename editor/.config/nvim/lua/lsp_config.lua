local lsp = require 'nvim_lsp'
local lsp_status = require 'lsp-status'
local diagnostic = require 'diagnostic'
local nvim_command = vim.api.nvim_command

local attach = function(client)
  lsp_status.on_attach(client)
  diagnostic.on_attach(client)

  local mapper = function(mode, key, result)
    vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
  end

  mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  mapper('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  mapper('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  mapper('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  mapper('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  mapper('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

  mapper('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  mapper('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>')

  mapper('n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>')

  mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')

  mapper('n', '<expr><c-space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

  mapper('n', '[g', '<cmd>PrevDiagnosticCycle<CR>')
  mapper('n', ']g', '<cmd>NextDiagnosticCycle<CR>')

  mapper('n', '<leader>d', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
  mapper('n', '<leader>od', '<cmd>OpenDiagnostic<CR>')
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
  solargraph = {
    settings = {
      solargraph = {
        useBundler = false,
        diagnostics = true,
      },
    },
  },
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
