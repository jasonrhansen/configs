local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
  ensure_installed = "maintained",

  highlight = {
    enable = true,
  },

  indent = {
    enable = false
  },

  textsubjects = {
      enable = true,
      keymaps = {
          ['.'] = 'textsubjects-smart',
      }
  },

  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["am"] = "@function.outer",
        ["im"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },

    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = "@parameter.inner",
        ["<leader>sp"] = "@parameter.inner",
        ["<leader>sf"] = "@function.outer",
        ["<leader>sm"] = "@function.outer",
      },
      swap_previous = {
        ["<leader>sA"] = "@parameter.inner",
        ["<leader>sP"] = "@parameter.inner",
        ["<leader>sF"] = "@function.outer",
        ["<leader>sM"] = "@function.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
}

vim.api.nvim_set_keymap("", "<leader>T", "<cmd>TSBufToggle highlight<CR>", {noremap=true, silent=true})
