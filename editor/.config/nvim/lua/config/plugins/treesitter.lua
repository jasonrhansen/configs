---@diagnostic disable: missing-fields
local M = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
    if ts_update ~= nil then
      ts_update()
    end
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
}

function M.config()
  local treesitter = require("nvim-treesitter.configs")

  local disabled_filetypes = { "html" }

  local disable = function(lang)
    return vim.tbl_contains(disabled_filetypes, lang)
  end

  local disable_indent = function(lang)
    return lang == "ruby" or lang == "rust" or disable(lang)
  end

  treesitter.setup({
    ensure_installed = "all",
    ignore_install = { "ipkg" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = disable,
    },
    indent = {
      enable = true,
      disable = disable_indent,
    },
    endwise = {
      enable = true,
      disable = disable,
    },
    textobjects = {
      select = {
        enable = true,
        disable = disable,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = { query = "@function.outer", desc = "Select outer part of function" },
          ["if"] = { query = "@function.inner", desc = "Select inner part of function" },
          ["am"] = { query = "@function.outer", desc = "Select outer part of method" },
          ["im"] = { query = "@function.inner", desc = "Select inner part of method" },
          ["ac"] = { query = "@class.outer", desc = "Select outer part of class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of class" },
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        },
      },
      move = {
        enable = true,
        disable = disable,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
        },
      },
    },
    query_linter = {
      enable = true,
      disable = disable,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
  })

  require("treesitter-context").setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        "class",
        "function",
        "method",
        -- 'for', -- These won't appear in the context
        -- 'while',
        -- 'if',
        -- 'switch',
        -- 'case',
      },
      -- Example for a specific filetype.
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      --   rust = {
      --       'impl_item',
      --   },
    },
    exact_patterns = {
      -- Example for a specific filetype with Lua patterns
      -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
      -- exactly match "impl_item" only)
      -- rust = true,
    },
    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
  })

  require("which-key").add({
    { "<leader>tT", "<cmd>TSBufToggle highlight<CR>", desc = "Toggle treesitter highlights" },
    { "<leader>tC", "<cmd>TSContextToggle<CR>", desc = "Toggle treesitter context" },
  })
end

return M
