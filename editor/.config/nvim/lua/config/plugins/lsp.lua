local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = {
    "nvim-lua/lsp-status.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
}

function M.config()
  -- In order for mason-lspconfig to work correctly the plugins need to setup in the following order
  -- 1. mason
  -- 2. mason-lspconfig
  -- 3. nvim-lspconfig
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

  local lspconfig = require("lspconfig")
  local lsp_status = require("lsp-status")

  -- Which LSP clients should automatically format when saving.
  local format_on_save_names = {
    "rust_analyzer",
    "gopls",
  }

  -- Which LSP clients to disable formatting for so null-ls can be used instead
  -- without it asking each time which formatter to use.
  local disable_formatting_names = {
    "typescript-tools",
    "solargraph",
    "lua_ls",
  }

  local pick_window = require("util").pick_window

  local format_buffer = function()
    vim.lsp.buf.format({
      filter = function(client)
        return not vim.tbl_contains(disable_formatting_names, client.name)
      end,
      async = true,
    })
  end

  local add_missing_import = function()
    vim.lsp.buf.code_action({
      filter = function(action)
        return action.kind == "quickfix" and string.find(action.title, "Import") == 1
      end,
      apply = true,
    })
  end

  local toggle_inlay_hints = function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
  end

  -- Keymaps that get added to a buffer when attaching an LSP client.
  local register_keymaps = function(buffer)
    require("which-key").add({
      buffer = buffer,
      { "gd", vim.lsp.buf.definition, desc = "Jump to definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Jump to declaration" },
      { "gy", vim.lsp.buf.type_definition, desc = "Jump to type definition" },
      { "gI", vim.lsp.buf.implementation, desc = "Jump to implementation" },
      { "gr", vim.lsp.buf.references, desc = "Get references" },
      { "g0", vim.lsp.buf.document_symbol, desc = "List document symbols" },
      { "gW", vim.lsp.buf.workspace_symbol, desc = "List workspace symbols" },
      { "<leader>gd", pick_window(vim.lsp.buf.definition), desc = "Pick window and jump to definition" },
      { "<leader>gD", pick_window(vim.lsp.buf.declaration), desc = "Pick window and jump to declaration" },
      { "<leader>gy", pick_window(vim.lsp.buf.type_definition), desc = "Pick window and jump to type definition" },
      { "<leader>gI", pick_window(vim.lsp.buf.implementation), desc = "Pick window and jump to implementation" },
      { "<leader>k", vim.lsp.buf.signature_help, desc = "Signature help" },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
      { "<F2>", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>a", vim.lsp.buf.code_action, desc = "Code action" },
      { "<leader>d", vim.diagnostic.open_float, desc = "Line diagnostics" },
      { "<leader>Q", vim.diagnostic.set_loclist, desc = "Open diagnostics in loclist" },
      { "<leader>F", format_buffer, desc = "Format buffer" },
      { "<leader>tI", toggle_inlay_hints, desc = "Toggle inlay type hints" },
      {
        "<leader>yi",
        add_missing_import,
        desc = "Add missing import",
        cond = function()
          -- typescript-tools provides its own "add missing imports"
          return not vim.tbl_contains({ "typescript", "javascript" }, vim.opt.filetype)
        end,
      },
      {
        mode = "v",
        { "<leader>f", format_buffer, desc = "Format range" },
        { "<leader>a", vim.lsp.buf.range_code_action, desc = "Code action for range" },
      },
    })
  end

  -- Shared attach function for all LSP clients.
  M.attach = function(client, buffer)
    lsp_status.on_attach(client, buffer)

    -- Register keymaps with which-key for the attached buffer
    register_keymaps(buffer)

    -- For some languages, format on save.
    if vim.tbl_contains(format_on_save_names, client.name) then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
    end
  end

  -- Language server configs
  local configs = {
    angularls = {
      filetypes = { "typescript", "html.angular", "html" },
    },
    bashls = {},
    cmake = {},
    cssls = {
      capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
            },
          },
        },
      },
    },
    dockerls = {},
    elmls = {},
    gopls = {},
    graphql = {},
    html = {
      capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
            },
          },
        },
      },
    },
    -- PHP
    intelephense = {},
    -- Java
    -- jdtls = {},
    jsonls = {
      capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
            },
          },
        },
      },
    },
    -- XML
    lemminx = {},
    -- C#, VB
    -- omnisharp = {},
    -- Python
    pyright = {},
    -- Rust
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          check = {
            command = "clippy",
          },
          completion = {
            postfix = {
              enable = false,
            },
          },
        },
      },
    },
    -- Ruby
    solargraph = {
      init_options = {
        formatting = false,
      },
      settings = {
        solargraph = {
          useBundler = false,
          diagnostics = true,
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
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
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library",
            },
            preloadFileSize = 200,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
          hint = {
            enable = true,
          },
        },
      },
    },
    sqlls = {
      cmd = { "sql-language-server", "up", "--method", "stdio" },
    },
    svelte = {},
    vimls = {},
    vuels = {},
    zls = {},
  }

  lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
    on_attach = M.attach,
    flags = {
      debounce_text_changes = 150,
    },
  })

  -- Initialize all language servers
  for name, config in pairs(configs) do
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Add server-specific capabilities
    capabilities = vim.tbl_extend("keep", capabilities, config.capabilities or {})

    -- Add lsp_status capabilities
    capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

    -- Add nvim_cmp capabilities
    capabilities = vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    config.capabilities = capabilities
    lspconfig[name].setup(config)
  end

  vim.diagnostic.config({
    underline = true,
    virtual_text = {
      spacing = 2,
      prefix = "■ ",
    },
    signs = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local signs = require("config.signs")
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Status config
  lsp_status.config({
    status_symbol = "  LSP:",
    indicator_errors = signs.Error,
    indicator_warnings = signs.Warning,
    indicator_info = signs.Information,
    indicator_hint = signs.Hint,
    indicator_ok = "✓",
    current_function = false,
  })
end

return M
