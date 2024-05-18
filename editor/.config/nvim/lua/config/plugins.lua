return {
  -- Show function signature when you type
  {
    -- Use my own fork with a workaround for issue https://github.com/hrsh7th/nvim-cmp/issues/1613,
    -- which causes input lag.
    "jasonrhansen/lsp_signature.nvim",
    branch = "input-lag-workaround",

    -- "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup()
    end,
  },

  -- Inject LSP diagnostics, code actions, and more via Lua
  {
    "nvimtools/none-ls.nvim", -- Community fork of jose-elias-alvarez/null-ls.nvim
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Enhanced vim.ui.select and vim.ui.input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({})
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

  -- Expand abbreviations for HTML like 'div>p#foo$*3>a' with '<c-y>,'
  "mattn/emmet-vim",

  -- Changes the working directory to the project root when you open a file.
  "airblade/vim-rooter",

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
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup({
        -- Configure nvim-comment to call this with hook.
        enable_autocmd = false,
      })
    end,
  },

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
        render = "virtual",
        virtual_symbol = '■',
      })
      local wk = require("which-key")
      wk.register({ ["<leader>tC"] = { "<cmd>HighlightColorsToggle<cr>", "Toggle highlight colors" } })
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

  -- Substitutions (preserving case and handling plurals): :%Subvert/facilit{y,ies}/building{,s}/g
  {
    "tpope/vim-abolish",
    init = function()
      -- Disable coercion mappings. I use vim-caser for that instead.
      vim.g.abolish_no_mappings = true
    end,
  },

  -- Easily change word casing with motions, text objects or visual mode.
  -- * gsm: MixedCase or PascalCase
  -- * gsc: camelCase
  -- * gs_: snake_case
  -- * gsu or gsU: UPPER_CASE
  -- * gs<space>: space case
  -- * gs- or gsk: dash-case or kebab-case
  -- * gsK: Title-Dash-Case or Title-Kebab-Case
  -- * gs.: dot.case
  "arthurxavierx/vim-caser",

  -- Syntax and indent files for KDL
  "imsnif/kdl.vim",

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
