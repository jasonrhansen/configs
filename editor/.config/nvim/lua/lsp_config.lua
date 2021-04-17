local lspconfig = require 'lspconfig'
local lsp_status = require 'lsp-status'

M = {}

-- Language server configs
local configs = {
  angularls = {},
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
            "vim", "Color", "c", "Group", "g", "s", "describe", "it", "before_each", "after_each", "use",
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
  -- ['<F2>'] = 'vim.lsp.buf.rename()',
  ['<c-k>'] = 'vim.lsp.buf.signature_help()',
  -- ['<expr><c-space'] = 'vim.lsp.buf.completion()',
  ['<leader>a'] = 'vim.lsp.buf.code_action()',
  -- ['<leader>rn'] = 'vim.lsp.buf.rename()',
  ['<leader>f'] = 'vim.lsp.buf.range_formatting()',
  ['<leader>F'] = 'vim.lsp.buf.formatting()',

  -- Diagnostics
  ['<F10>'] = 'require"lsp_config".toggle_diagnostic_virtual_text()',
}

-- Shared attach function for all LSP clients.
local attach = function(client)
  lsp_status.on_attach(client)

  -- Add LSP keybindings
  for key, expression in pairs(keymaps) do
    vim.api.nvim_buf_set_keymap(0, 'n', key, '<cmd>lua ' .. expression .. '<CR>', {noremap=true, silent=true})
  end
end

lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    on_attach = attach
  }
)

-- Inititialize all language servers
for name, config in pairs(configs) do
  -- Add lsp_status capabilities
  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)

  config.capabilities.textDocument.completion.completionItem.snippetSupport = true
  config.capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }

  lspconfig[name].setup(config)
end


-- Diagnostics config
local virtual_text_config = {
  spacing = 2,
  prefix = '~',
}

local show_virtual_text = true;

-- Allow virtual text to be toggled for a buffer.
M.toggle_diagnostic_virtual_text = function()
  if vim.b.diagnostic_show_virtual_text == nil then
    -- Hasn't been set yet, so set to default.
    vim.b.diagnostic_show_virtual_text = show_virtual_text
  end
  vim.b.diagnostic_show_virtual_text = not vim.b.diagnostic_show_virtual_text
  print('Turned diagnostic virtual text', vim.b.diagnostic_show_virtual_text and 'ON' or 'OFF')
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = {
      -- Signify priority is 10, so make diagnostic signs higher than that.
      priority = 11,
    },
    underline = true,
    update_in_insert = false,
    virtual_text = function(bufnr, _)
      local ok, show = pcall(vim.api.nvim_buf_get_var, bufnr, 'diagnostic_show_virtual_text')

      -- Buffer variable not set, so use default.
      if not ok then
        show = show_virtual_text;
      end

      if show then
        return virtual_text_config
      end

      return false
    end,
  }
)

local sign_error = '✗';
local sign_warning = '⚠';
local sign_information = 'ⓘ ';
local sign_hint = 'H';

vim.fn.sign_define('LspDiagnosticsSignError', {
  text = sign_error,
  texthl = 'LspDiagnosticsSignError'
})

vim.fn.sign_define('LspDiagnosticsSignWarning', {
  text = sign_warning,
  texthl = 'LspDiagnosticsSignWarning'
})

vim.fn.sign_define('LspDiagnosticsSignInformation', {
  text = sign_information,
  texthl = 'LspDiagnosticsSignInformation'
})

vim.fn.sign_define('LspDiagnosticsSignHint', {
  text = sign_hint,
  texthl = 'LspDiagnosticsSignHint'
})

-- Use the same color for all virtual text.
vim.cmd('highlight link LspDiagnosticsVirtualTextError LspDiagnosticsVirtualTextHint')
vim.cmd('highlight link LspDiagnosticsVirtualTextWarning LspDiagnosticsVirtualTextHint')
vim.cmd('highlight link LspDiagnosticsVirtualTextInformation LspDiagnosticsVirtualTextHint')

-- Status config
lsp_status.register_progress()
lsp_status.config({
  status_symbol = "",
  indicator_errors = sign_error,
  indicator_warnings = sign_warning,
  indicator_info = sign_information,
  indicator_hint = sign_hint,
  indicator_ok = '✓',
  spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
})

return M
