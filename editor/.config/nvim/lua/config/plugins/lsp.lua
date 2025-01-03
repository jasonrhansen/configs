local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = {
    "nvim-lua/lsp-status.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "pmizio/typescript-tools.nvim",
    "nvimtools/none-ls.nvim", -- Community fork of jose-elias-alvarez/null-ls.nvim
    "nvim-lua/plenary.nvim", -- Needed by none-ls, and typescript-tools
    "saghen/blink.cmp",
  },
}

local function setup_none_ls(attach)
  local null_ls = require("null-ls")
  null_ls.setup({
    should_attach = function(bufnr)
      return not require("util").is_large_file(bufnr)
    end,
    on_attach = function(client, buffer)
      attach(client, buffer)
    end,
    sources = {
      null_ls.builtins.formatting.rubocop,
    },
  })
end

local function setup_typescript_tools(attach)
  require("typescript-tools").setup({
    should_attach = function(bufnr)
      return not require("util").is_large_file(bufnr)
    end,

    on_attach = function(client, bufnr)
      attach(client, bufnr)

      require("which-key").add({
        buffer = bufnr,
        { "<leader>y", group = "TypeScript Tools" },
        { "<leader>yo", "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize imports" },
        { "<leader>ys", "<cmd>TSToolsSortImports<cr>", desc = "Sort imports" },
        { "<leader>yu", "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "Remove unused imports" },
        { "<leader>yi", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add missing imports" },
        { "<leader>yf", "<cmd>TSToolsFixAll<cr>", desc = "Fix all fixable errors" },
        { "<leader>yd", "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go to source definition" },
        { "<leader>yr", "<cmd>TSToolsRenameFile<cr>", desc = "Rename current file and update connected files" },
      })
    end,

    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = "insert_leave",
      -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
      -- "remove_unused_imports"|"organize_imports") -- or string "all"
      -- to include all supported code actions
      -- specify commands exposed as code_actions
      expose_as_code_action = {},
      -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = nil,
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- memory limit in megabytes or "auto"(basically no limit)
      tsserver_max_memory = "auto",
      -- described below
      tsserver_format_options = {},
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      -- locale of all tsserver messages, supported locales you can find here:
      -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
      tsserver_locale = "en",
      -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
      complete_function_calls = false,
      include_completions_with_insert_text = true,
      -- CodeLens
      -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
      -- possible values: ("off"|"all"|"implementations_only"|"references_only")
      code_lens = "off",
      -- by default code lenses are displayed on all referencable values and for some of you it can
      -- be too much this option reduce count of them by removing member references from lenses
      disable_member_code_lens = true,
    },
  })
end

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
  local attach = function(client, buffer)
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
    on_attach = attach,
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

    -- Add blink.cmp capabilities
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

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

  setup_none_ls(attach)
  setup_typescript_tools(attach)
end

return M
