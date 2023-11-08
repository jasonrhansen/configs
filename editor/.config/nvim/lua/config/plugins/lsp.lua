local M = {
  "neovim/nvim-lspconfig",
  name = "lsp",
  event = "BufReadPre",
  dependencies = {
    "nvim-lua/lsp-status.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
}

function M.config()
  local lspconfig = require("lspconfig")
  local lsp_status = require("lsp-status")
  local wk = require("which-key")

  -- Which LSP clients should automatically format when saving.
  local format_on_save_names = {
    "rust_analyzer",
    "gopls",
  }

  -- Which LSP clients should get inlay type hints.
  local inlay_typehint_names = {
    "rust_analyzer",
    "typescript-tools",
  }

  -- Which LSP clients to disable formatting for so null-ls can be used instead
  -- without it asking each time which formatter to use.
  local disable_formatting_names = {
    "typescript-tools",
    "solargraph",
    "lua_ls",
  }

  local show_virtual_text = true

  -- Allow virtual text to be toggled for a buffer.
  local toggle_diagnostic_virtual_text = function()
    if vim.b.diagnostic_show_virtual_text == nil then
      -- Hasn't been set yet, so set to default.
      vim.b.diagnostic_show_virtual_text = show_virtual_text
    end
    vim.b.diagnostic_show_virtual_text = not vim.b.diagnostic_show_virtual_text
    print("Turned diagnostic virtual text", vim.b.diagnostic_show_virtual_text and "ON" or "OFF")
  end

  local pick_window = require("util").pick_window

  local format_buffer = function()
    vim.lsp.buf.format({
      filter = function(client)
        return not vim.tbl_contains(disable_formatting_names, client.name)
      end,
      async = true,
    })
  end

  -- Normal mode keymaps that get added to a buffer when attaching an LSP client.
  local keymaps = {
    -- normal mode
    n = {
      -- Go to things
      gd = { vim.lsp.buf.definition, "Jump to definition" },
      gD = { vim.lsp.buf.declaration, "Jump to declaration" },
      gy = { vim.lsp.buf.type_definition, "Jump to type definition" },
      gI = { vim.lsp.buf.implementation, "Jump to implementation" },
      gr = { vim.lsp.buf.references, "Get references" },
      g0 = { vim.lsp.buf.document_symbol, "List document symbols" },
      gW = { vim.lsp.buf.workspace_symbol, "List workspace symbols" },
      ["<leader>gd"] = { pick_window(vim.lsp.buf.definition), "Pick window and jump to definition" },
      ["<leader>gD"] = { pick_window(vim.lsp.buf.declaration), "Pick window and jump to declaration" },
      ["<leader>gy"] = { pick_window(vim.lsp.buf.type_definition), "Pick window and jump to type definition" },
      ["<leader>gI"] = { pick_window(vim.lsp.buf.implementation), "Pick window and jump to implementation" },
      K = { vim.lsp.buf.hover, "Hover" },
      ["<leader>k"] = { vim.lsp.buf.signature_help, "Signature help" },
      ["<leader>rn"] = { vim.lsp.buf.rename, "Rename" },
      ["<F2>"] = { vim.lsp.buf.rename, "Rename" },
      ["<leader>a"] = { vim.lsp.buf.code_action, "Code action" },
      ["<leader>d"] = { vim.diagnostic.open_float, "Line diagnostics" },
      ["[d"] = { vim.diagnostic.goto_prev, "Jump to previous line diagnostic" },
      ["]d"] = { vim.diagnostic.goto_next, "Jump to next line diagnostic" },
      ["<leader>Q"] = { vim.diagnostic.set_loclist, "Open diagnostics in loclist" },
      ["<leader>f"] = { format_buffer, "Format buffer" },
      ["<leader>V"] = { toggle_diagnostic_virtual_text, "Toggle diagnostic virtual text" },
    },
    -- visual mode
    v = {
      ["<leader>f"] = { format_buffer, "Format range" },
      ["<leader>a"] = { vim.lsp.buf.range_code_action, "Code action for range" },
    },
  }

  -- Shared attach function for all LSP clients.
  local attach = function(client, buffer)
    lsp_status.on_attach(client)

    if vim.tbl_contains(inlay_typehint_names, client.name) then
      require("lsp-inlayhints").on_attach(client, buffer)
    end

    -- Register keymaps with which-key
    for mode, mappings in pairs(keymaps) do
      wk.register(mappings, { buffer = 0, mode = mode })
    end

    if vim.tbl_contains(format_on_save_names, client.name) then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
    end
  end

  -- Language server configs
  local configs = {
    angularls = {},
    bashls = {},
    cmake = {},
    cssls = {},
    dockerls = {},
    elmls = {},
    gopls = {},
    graphql = {},
    html = {},
    -- PHP
    intelephense = {},
    -- Java
    -- jdtls = {},
    jsonls = {},
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
    local capabilities = config.capabilities or {}

    -- Add lsp_status capabilities
    capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

    -- Add nvim_cmp capabilities
    capabilities = vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    config.capabilities = capabilities
    lspconfig[name].setup(config)
  end

  local null_ls = require("null-ls")
  null_ls.setup({
    should_attach = function(bufnr)
      return not require("util").is_large_file(bufnr)
    end,
    on_attach = attach,
    sources = {
      null_ls.builtins.formatting.rubocop,
    },
  })

  require("typescript-tools").setup({
    should_attach = function(bufnr)
      return not require("util").is_large_file(bufnr)
    end,

    on_attach = function(client, bufnr)
      attach(client, bufnr)

      wk.register({
        name = "TypeScript Tools",
        prefix = "<leader>y",
        o = { "<cmd>TSToolsOrganizeImports<cr>", "Organize imports" },
        s = { "<cmd>TSToolsSortImports<cr>", "Sort imports" },
        u = { "<cmd>TSToolsRemoveUnusedImports<cr>", "Remove unused imports" },
        i = { "<cmd>TSToolsAddMissingImports<cr>", "Add missing imports" },
        f = { "<cmd>TSToolsFixAll<cr>", "Fix all fixable errors" },
        d = { "<cmd>TSToolsGoToSourceDefinition<cr>", "Go to source definition" },
        r = { "<cmd>TSToolsRenameFile<cr>", "Rename current file and update connected files" },
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

  -- Diagnostics config
  local virtual_text_config = {
    spacing = 2,
    prefix = "■ ",
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
