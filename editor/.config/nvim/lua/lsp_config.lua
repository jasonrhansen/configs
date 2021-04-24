local lspconfig = require 'lspconfig'
local lsp_status = require 'lsp-status'

local node_lib_path = vim.fn.expand("$HOME/.nvm/versions/node/v14.16.1/lib")
local angularls_path = node_lib_path .. "/node_modules/@angular/language-server"
local angularls_cmd = {"ngserver", "--stdio", "--tsProbeLocations", node_lib_path , "--ngProbeLocations", angularls_path}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.expand("$HOME/dev/others/lua-language-server")
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

-- Language server configs
local configs = {
  angularls = {
    cmd = angularls_cmd,
    on_new_config = function(new_config)
      new_config.cmd = angularls_cmd
    end,
  },
  bashls = {},
  cmake = {},
  cssls = {},
  dockerls = {},
  gopls = {},
  graphql = {},
  html = {},
  -- PHP
  intelephense = {},
  -- Java
  -- jdtls = {},
  jsonls = {},
  -- C#, VB
  -- omnisharp = {},
  -- Python
  pyls = {},
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
    cmd = {sumneko_binary, "-E", sumneko_root_path.."/main.lua"},
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          enable = true,
          globals = {
            "vim", "Color", "c", "Group", "g", "s", "describe", "it", "before_each", "after_each", "use",
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
          preloadFileSize = 200,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  },
  sqlls = {
    cmd = {"sql-language-server", "up", "--method", "stdio"},
  },
  svelte = {},
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
local toggle_diagnostic_virtual_text = function()
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
local sign_information = 'i';
local sign_hint = 'ℎ';

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
  status_symbol = "  LSP:",
  indicator_errors = sign_error,
  indicator_warnings = sign_warning,
  indicator_info = sign_information,
  indicator_hint = sign_hint,
  indicator_ok = '✓',
  spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
})

-- Add LspLog command
function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end
vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')

-- Add LspRestart command
function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

return {
  toggle_diagnostic_virtual_text = toggle_diagnostic_virtual_text,
  sign_error = sign_error,
  sign_warning = sign_warning,
  sign_information = sign_information,
  sign_hint = sign_hint,
}
