local lspconfig = require("lspconfig")
local lsp_status = require("lsp-status")
local null_ls = require("null-ls")
local wk = require("which-key")

local M = {}

local node_lib_path = vim.fn.expand("$HOME/.nvm/versions/node/v14.16.1/lib")
local angularls_path = node_lib_path .. "/node_modules/@angular/language-server"
local angularls_cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  node_lib_path,
  "--ngProbeLocations",
  angularls_path,
}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has("win32") == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.expand("$HOME/dev/others/lua-language-server")
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

null_ls.config({
  sources = {
    -- npm install -g @fsouza/prettierd
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.rubocop,
    -- cargo install stylua
    null_ls.builtins.formatting.stylua.with({
      args = { "-s", "--indent-type", "Spaces", "--indent-width", "2", "-" },
    }),
  },
})

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
  ["null-ls"] = {},
  -- C#, VB
  -- omnisharp = {},
  -- Python
  pyright = {},
  -- rust-analyzer is configured in rust_tools.lua, so no need to configure here.
  -- rust_analyzer = {},
  -- Ruby
  solargraph = {
    settings = {
      solargraph = {
        useBundler = false,
        diagnostics = true,
        -- Use null-ls wth rubocop for formatting.
        formatting = false,
      },
    },
  },
  -- Swift, C/C++/Objective-C
  sourcekit = {},
  sumneko_lua = {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          enable = true,
          globals = {
            "vim",
            "Color",
            "c",
            "Group",
            "g",
            "s",
            "describe",
            "it",
            "before_each",
            "after_each",
            "use",
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
          preloadFileSize = 200,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  sqlls = {
    cmd = { "sql-language-server", "up", "--method", "stdio" },
  },
  svelte = {},
  tsserver = {
    on_attach = function(client, bufnr)
      -- disable tsserver formatting in favor of null-ls
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      local ts_utils = require("nvim-lsp-ts-utils")

      ts_utils.setup({
        debug = false,
        disable_commands = false,
        enable_import_on_completion = true,

        -- import all
        import_all_timeout = 5000, -- ms
        import_all_priorities = {
          buffers = 4, -- loaded buffer names
          buffer_content = 3, -- loaded buffer content
          local_files = 2, -- git files or files with relative path markers
          same_file = 1, -- add to existing import statement
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,
      })

      -- required to fix code action ranges and filter diagnostics
      ts_utils.setup_client(client)

      -- no default maps, so you may want to define some here
      local opts = { silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
    end,
  },
  vimls = {},
  vuels = {},
  yamlls = {},
  zls = {},
}

-- Which LSP clients should automatically format when saving.
M.format_on_save_names = {
  "rust_analyzer",
  "gopls",
}

-- Normal mode keymaps that get added to a buffer when attaching an LSP client.
local keymaps = {
  -- normal mode
  n = {
    -- Go to things
    gd = { "vim.lsp.buf.definition()", "Jump to definition" },
    gD = { "vim.lsp.buf.declaration()", "Jump to declaration" },
    gy = { "vim.lsp.buf.type_definition()", "Jump to type definition" },
    gi = { "vim.lsp.buf.implementation()", "Jump to implementation" },
    gr = { "vim.lsp.buf.references()", "Get references" },
    g0 = { "vim.lsp.buf.document_symbol()", "List document symbols" },
    gW = { "vim.lsp.buf.workspace_symbol()", "List workspace symbols" },
    K = { "vim.lsp.buf.hover()", "Hover" },
    ["<leader>k"] = { "vim.lsp.buf.signature_help()", "Signature help" },
    ["<leader>rn"] = { "vim.lsp.buf.rename()", "Rename" },
    ["<F2>"] = { "vim.lsp.buf.rename()", "Rename" },
    ["<leader>a"] = { "vim.lsp.buf.code_action()", "Code action" },
    ["<leader>d"] = { "vim.lsp.diagnostic.show_line_diagnostics()", "Line diagnostics" },
    ["[d"] = { "vim.lsp.diagnostic.goto_prev()", "Jump to previous line diagnostic" },
    ["]d"] = { "vim.lsp.diagnostic.goto_next()", "Jump to next line diagnostic" },
    ["<leader>Q"] = { "vim.lsp.diagnostic.set_loclist()", "Open diagnostics in loclist" },
    ["<leader>f"] = { "vim.lsp.buf.formatting()", "Format buffer" },
    ["<leader>V"] = { "require('config.lsp').toggle_diagnostic_virtual_text()", "Toggle diagnostic virtual text" },
  },
  -- visual mode
  v = {
    ["<leader>f"] = { "vim.lsp.buf.range_formatting()", "Format range" },
  },
}

for _, mappings in pairs(keymaps) do
  for _, config in pairs(mappings) do
    config[1] = "<cmd>lua " .. config[1] .. "<cr>"
  end
end

-- Shared attach function for all LSP clients.
local function attach(client)
  lsp_status.on_attach(client)

  -- Register keymaps with which-key
  for mode, mappings in pairs(keymaps) do
    wk.register(mappings, { buffer = 0, mode = mode })
  end

  if vim.tbl_contains(M.format_on_save_names, client.name) then
    vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
  end
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_attach = attach,
  flags = {
    debounce_text_changes = 150,
  },
})

-- Inititialize all language servers
for name, config in pairs(configs) do
  -- Add lsp_status capabilities
  config.capabilities = vim.tbl_extend("keep", config.capabilities or {}, lsp_status.capabilities)

  config.capabilities.textDocument.completion.completionItem.snippetSupport = true
  config.capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  config.capabilities = require("cmp_nvim_lsp").update_capabilities(config.capabilities)

  lspconfig[name].setup(config)
end

-- Diagnostics config
local virtual_text_config = {
  spacing = 2,
  prefix = "■ ",
}

local show_virtual_text = true

-- Allow virtual text to be toggled for a buffer.
function M.toggle_diagnostic_virtual_text()
  if vim.b.diagnostic_show_virtual_text == nil then
    -- Hasn't been set yet, so set to default.
    vim.b.diagnostic_show_virtual_text = show_virtual_text
  end
  vim.b.diagnostic_show_virtual_text = not vim.b.diagnostic_show_virtual_text
  print("Turned diagnostic virtual text", vim.b.diagnostic_show_virtual_text and "ON" or "OFF")
end

M.signs = {
  Error = " ",
  Warning = " ",
  Hint = " ",
  Information = " ",
}

vim.diagnostic.config({
  underline = true,
  virtual_text = function(_, bufnr)
    local ok, show = pcall(vim.api.nvim_buf_get_var, bufnr, "diagnostic_show_virtual_text")

    -- Buffer variable not set, so use default.
    if not ok then
      show = show_virtual_text
    end

    if show then
      return virtual_text_config
    end

    return false
  end,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

for type, icon in pairs(M.signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Status config
lsp_status.register_progress()
lsp_status.config({
  status_symbol = "  LSP:",
  indicator_errors = M.signs.Error,
  indicator_warnings = M.signs.Warning,
  indicator_info = M.signs.Information,
  indicator_hint = M.signs.Hint,
  indicator_ok = "✓",
  spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
})

return M
