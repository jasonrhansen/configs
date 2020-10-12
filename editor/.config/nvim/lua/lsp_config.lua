local lsp = require 'nvim_lsp'
local lsp_status = require 'lsp-status'
local diagnostic = require 'diagnostic'

lsp_status.register_progress()
lsp_status.config({
  status_symbol = "",
  indicator_errors = '✗',
  indicator_warnings = '⚠',
  indicator_info = 'i',
  indicator_hint = '>',
  indicator_ok = '✓',
  spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
})

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

  mapper('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  mapper('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  mapper('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>')

  mapper('n', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
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
  cmake = {},
  cssls = {},
  dockerls = {},
  gopls = {},
  html = {},
  -- PHP
  intelephense = {},
  -- Java
  jdtls = {},
  jsonls = {},
  -- C#, VB
  omnisharp = {},
  -- Python
  pyls = {},
  -- Linting of JavaScript, TypeScript, JSON
  -- rome = {},
  rust_analyzer = {},
  -- Ruby
  solargraph = {
    settings = {
      solargraph = {
        useBundler = false,
        diagnostics = true,
      },
    },
  },
  -- Swift, C/C++/Objective-C
  sourcekit = {},
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
  sqlls = {},
  tsserver = {},
  vimls = {},
  vuels = {},
  yamlls = {},
}

-- Inititialize all language servers
for name, config in pairs(configs) do
  -- Add lsp_status capabilities
  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

  lsp[name].setup(config)
end

local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        -- Close with esc in insert mode.
        ["<esc>"] = actions.close,
      },
    },
  }
}
