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
  local null_ls = require("null-ls")
  local wk = require("which-key")

  local sumneko_runtime_path = vim.split(package.path, ";")
  table.insert(sumneko_runtime_path, "lua/?.lua")
  table.insert(sumneko_runtime_path, "lua/?/init.lua")

  local node_path = vim.fn.expand("$HOME/.nvm/versions/node/v16.14.0")
  local node_lib_path = node_path .. "/lib"
  local tsserver_cmd = { node_path .. "/bin/typescript-language-server", "--stdio" }
  local angularls_path = node_lib_path .. "/node_modules/@angular/language-server"
  local angularls_cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations",
    node_lib_path,
    "--ngProbeLocations",
    angularls_path,
  }

  -- Which LSP clients should automatically format when saving.
  local format_on_save_names = {
    "rust_analyzer",
    "gopls",
  }

  -- Which LSP clients should get inlay type hints.
  local inlay_typehint_names = {
    "rust_analyzer",
    "tsserver",
  }

  -- Which LSP clients to disable formatting for so null-ls can be used instead
  -- without it asking each time which formatter to use.
  local disable_formatting_names = {
    "tsserver",
    "solargraph",
    "sumneko_lua",
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
      ["<leader>f"] = {
        function()
          vim.lsp.buf.format({ async = true })
        end,
        "Format buffer",
      },
      ["<leader>V"] = { toggle_diagnostic_virtual_text, "Toggle diagnostic virtual text" },
    },
    -- visual mode
    v = {
      ["<leader>f"] = { vim.lsp.buf.range_formatting, "Format range" },
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
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true })")
    end

    if vim.tbl_contains(disable_formatting_names, client.name) then
      -- disable formatting in favor of null-ls
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end
  end

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
    sumneko_lua = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = sumneko_runtime_path,
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
            library = vim.api.nvim_get_runtime_file("", true),
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
    tsserver = {
      cmd = tsserver_cmd,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },

      on_attach = function(client, bufnr)
        attach(client, bufnr)

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
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rf", ":TSLspRenameFile<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>I", ":TSLspImportAll<CR>", opts)
      end,
    },
    vimls = {},
    vuels = {},
    yamlls = {},
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

  null_ls.setup({
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
