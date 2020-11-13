local lsp = require 'nvim_lsp'
local lsp_status = require 'lsp-status'
local telescope = require 'telescope'
local treesitter = require 'nvim-treesitter.configs'

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

treesitter.setup {
  highlight = {
    enable = true,
  },
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     keymaps = {
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = "@class.inner",
  --     },
  --   },
  --   lsp_interop = {
  --     enable = true,
  --     peek_definition_code = {
  --       ["df"] = "@function.outer",
  --       ["dF"] = "@class.outer",
  --     },
  --   },
  -- },
}

local attach = function(client)
  lsp_status.on_attach(client)

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

  mapper('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  mapper('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

  mapper('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  mapper('n', '<leader>od', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
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

telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- Close with esc in insert mode.
        ["<esc>"] = actions.close,
      },
    },
    -- Color devicons slow it down too much for large projects.
    color_devicons = false,
  }
}

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
