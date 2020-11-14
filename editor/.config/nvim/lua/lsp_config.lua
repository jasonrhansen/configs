local nvim_lsp = require 'nvim_lsp'
local lsp_status = require 'lsp-status'

-- Language server configs
local configs = {
  -- angularls = {},
  bashls = {},
  cmake = {},
  cssls = {},
  dockerls = {},
  gopls = {},
  html = {},
  -- PHP
  intelephense = {},
  -- Java
  -- jdtls = {},
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
  -- tsserver = {},
  vimls = {},
  vuels = {},
  yamlls = {},
}

-- Normal mode keymaps that get added to a buffer when attaching an LSP client.
local keymaps = {
  -- Go to things
  gd = 'vim.lsp.buf.definition()',
  gD = 'vim.lsp.buf.declaration()',
  gy = 'vim.lsp.buf.type_definition()',
  gi = 'vim.lsp.buf.implementation()',
  gr = 'vim.lsp.buf.references()',
  g0 = 'vim.lsp.buf.document_symbol()',
  gW = 'vim.lsp.buf.workspace_symbol()',

  -- Misc. actions
  K = 'vim.lsp.buf.hover()',
  ['<F2>'] = 'vim.lsp.buf.rename()',
  ['<c-k>'] = 'vim.lsp.buf.signature_help()',
  ['<expr><c-space'] = 'vim.lsp.buf.completion()',
  ['<leader>a'] = 'vim.lsp.buf.code_action()',
  ['<leader>rn'] = 'vim.lsp.buf.rename()',
  ['<leader>f'] = 'vim.lsp.buf.range_formatting()',
  ['<leader>F'] = 'vim.lsp.buf.formatting()',

  -- Diagnostics
  ['[g'] = 'vim.lsp.diagnostic.goto_prev()',
  [']g'] = 'vim.lsp.diagnostic.goto_next()',
  ['<leader>d'] = 'vim.lsp.diagnostic.show_line_diagnostics()',
  ['<leader>od'] = 'vim.lsp.diagnostic.set_locallist()',
  ['<F10>'] = 'Toggle_diagnostic_virtual_text()',
}

-- Shared attach function for all LSP clients.
local attach = function(client)
  lsp_status.on_attach(client)

  -- Add LSP keybindings
  for key, expression in pairs(keymaps) do
    vim.fn.nvim_buf_set_keymap(0, 'n', key, '<cmd>lua ' .. expression .. '<CR>', {noremap=true, silent=true})
  end
end

nvim_lsp.util.default_config = vim.tbl_extend(
  "force",
  nvim_lsp.util.default_config,
  {
    on_attach = attach
  }
)

-- Inititialize all language servers
for name, config in pairs(configs) do
  -- Add lsp_status capabilities
  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

  nvim_lsp[name].setup(config)
end


-- Diagnostics config
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = {
      -- Signify priority is 10, so make diagnostic signs higher than that.
      priority = 11,
    },
    underline = true,
    update_in_insert = false,
    virtual_text = function(bufnr, client_id)
      local ok, show = pcall(vim.api.nvim_buf_get_var, bufnr, 'diagnostic_show_virtual_text')

      if ok and show then
        return {
          spacing = 4,
          prefix = '~',
        }
      end

      return false
    end,
  }
)

vim.fn.sign_define('LspDiagnosticsSignError', {
  text = '✗',
  texthl = 'LspDiagnosticsSignError'
})

vim.fn.sign_define('LspDiagnosticsSignWarning', {
  text = '⚠',
  texthl = 'LspDiagnosticsSignWarning'
})

vim.fn.sign_define('LspDiagnosticsSignInformation', {
  text = 'ⓘ',
  texthl = 'LspDiagnosticsSignInformation'
})

vim.fn.sign_define('LspDiagnosticsSignHint', {
  text = 'H',
  texthl = 'LspDiagnosticsSignHint'
})

Toggle_diagnostic_virtual_text = function()
  vim.b.diagnostic_show_virtual_text = not vim.b.diagnostic_show_virtual_text
  print('Turned diagnostic virtual text', vim.b.diagnostic_show_virtual_text and 'ON' or 'OFF')
end


-- Status config
lsp_status.register_progress()
lsp_status.config({
  status_symbol = "",
  indicator_errors = '✗',
  indicator_warnings = '⚠',
  indicator_info = 'ⓘ ',
  indicator_hint = 'H🛈',
  indicator_ok = '✓',
  spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
})
