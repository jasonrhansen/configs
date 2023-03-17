return {
  -- Progress indicator
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({
        text = {
          spinner = "circle_halves",
        },
        window = {
          relative = "editor",
        },
        sources = {
          -- Because of integration with ts-node-action, every time the cursor position
          -- changes a null-ls notification is shown, which can be quite annoying, so ignore them.
          ["null-ls"] = {
            ignore = true,
          },
        },
      })
    end,
  },

  -- Show function signature when you type
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
    end,
  },

  -- Inlay type hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "LspAttach",
    config = function()
      require("lsp-inlayhints").setup({
        inlay_hints = { highlight = "Comment", only_current_line = true },
      })
    end,
  },

  -- Utilities to improve the TypeScript development experience for Neovim's built-in LSP client
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim", "jose-elias-alvarez/null-ls.nvim" },
  },

  -- Inject LSP diagnostics, code actions, and more via Lua
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Enhanced vim.ui.select and vim.ui.input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          override = function(conf)
            -- TODO: Remove this workaround when https://github.com/neovim/neovim/issues/19464 is fixed.
            conf.height = 2
          end,
        },
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
  },
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  -- Tmux
  "christoomey/vim-tmux-navigator",
  { "tmux-plugins/vim-tmux", ft = "tmux" },

  -- Git
  { "tpope/vim-git", cmd = "Git" },
  "tpope/vim-fugitive",
  "rhysd/committia.vim",
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

  -- Color themes
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_colors = { border = "#292E42" }
    end
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup({
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
    end
  },

  -- Expand abbreviations for HTML like 'div>p#foo$*3>a' with '<c-y>,'
  "mattn/emmet-vim",

  -- Changes the working directory to the project root when you open a file.
  "airblade/vim-rooter",

  -- Automatically toggle relative line numbers based on mode.
  "ericbn/vim-relativize",

  -- Highlight and search for todo comments like TODO, HACK, BUG
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },

  -- Sets the commentstring option based on the cursor location in the file via treesitter queries.
  -- Useful when there are embedded languages in certain types of files.
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Automatically adjust shiftwidth and expandtab based on the current file
  "tpope/vim-sleuth",

  -- Easily add/delete/change 'surroundings': parentheses, brackets, quotes, XML
  -- tags, etc. [cs, ds, ys, yss]
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- ]q for :cnext. [q for :cprevious. ]a for :next. [b for :bprevious, etc.
  "tpope/vim-unimpaired",

  -- Add emacs key bindings to vim in insert and command-line modes.
  "maxbrunsfeld/vim-emacs-bindings",

  -- Vim sugar for the UNIX shell commands that need it the most (:Delete,
  -- :Rename, :Mkdir, etc.)
  "tpope/vim-eunuch",

  -- Quickly switch between Angular files
  "softoika/ngswitcher.vim",

  -- Highlight hex and RGB colors in code
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
      })
      local wk = require("which-key")
      wk.register({ ["<leader>C"] = { "<cmd>HighlightColorsToggle<cr>", "Toggle highlight colors" } })
    end,
  },

  -- Icons to use in the status bar
  "ryanoasis/vim-devicons",

  -- Adds more text objects to operate on like (), {}, [], <>, and t for tags.
  "wellle/targets.vim",

  -- Close buffers without closing windows and messing up the layout.
  "moll/vim-bbye",

  -- Internal modeline support allows all sorts of annoying and potentially insecure options to be set.
  -- This plugin implements a more heavily restricted version.
  "ciaranm/securemodelines",

  -- Sessions
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
      })
    end,
  },
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require("session-lens").setup({})
    end,
  },

  -- Language plugins
  "jparise/vim-graphql",
  "cespare/vim-toml",
  "kchmck/vim-coffee-script",
  "mustache/vim-mustache-handlebars",
  "tpope/vim-rails",
  "fladson/vim-kitty", -- kitty.conf

  -- Muliple cursors
  {
    "mg979/vim-visual-multi",
    config = function()
      vim.g.VM_mouse_mappings = 1
    end,
  },

  -- Fix neovim CursorHold and CursorHoldI autocmd events (performance bug)
  {
    "antoinemadec/FixCursorHold.nvim",
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },

  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk" },
        timeout = vim.o.timeoutlen,
        clear_empty_lines = true,
        keys = function()
          return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
        end,
      })
    end,
  },

  -- Make certain mappings dot-repeatable.
  "tpope/vim-repeat",
}
