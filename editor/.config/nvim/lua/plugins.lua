-- On a new machine packer can be installed by cloning the repo:
-- git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  -- use 'glepnir/lspsaga.nvim'
  use {
    'jasonrhansen/lspsaga.nvim',
    branch = 'finder-preview-fixes'
  }
  use 'onsails/lspkind-nvim'
  use 'folke/trouble.nvim'

  -- Improved quickfix window
  use {
    'kevinhwang91/nvim-bqf',
    config = function()
      require('bqf').setup()
    end
  }

  -- Displays a popup with possible key bindings of the command you started typing
  use 'folke/which-key.nvim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-treesitter/playground',
    requires = 'nvim-treesitter/nvim-treesitter'
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = 'nvim-treesitter/nvim-treesitter'
  }

  -- Treesitter integration with the Angular framework.
  use {
    'nvim-treesitter/nvim-treesitter-angular',
    requires = 'nvim-treesitter/nvim-treesitter'
  }

  -- Location and syntax aware text objects which *do what you mean*
  use {
    'RRethy/nvim-treesitter-textsubjects',
    requires = 'nvim-treesitter/nvim-treesitter'
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
  }
  use {
    'nvim-telescope/telescope-fzy-native.nvim',
    requires = 'nvim-telescope/telescope.nvim'
  }

  -- Buffer line
  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Snippets
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- Autopairs
  use 'steelsojka/pears.nvim'
  use 'tpope/vim-endwise'

  -- Tmux
  use 'christoomey/vim-tmux-navigator'
  use 'edkolev/tmuxline.vim'
  use {'tmux-plugins/vim-tmux', ft = 'tmux'}

  -- Status line
  use 'hoob3rt/lualine.nvim'

  -- Git
  use 'tpope/vim-git'
  use 'tpope/vim-fugitive'
  use 'rhysd/committia.vim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use 'sindrets/diffview.nvim' -- Open with :DiffviewOpen

  -- Color themes
  use 'nanotech/jellybeans.vim'
  use 'glepnir/zephyr-nvim'
  use {
    'briones-gabriel/darcula-solid.nvim',
    requires = 'rktjmp/lush.nvim'
  }
  use 'shaunsingh/solarized.nvim'
  use 'folke/tokyonight.nvim'

  -- File manager
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Expand abbreviations for HTML like 'div>p#foo$*3>a' with '<c-y>,'
  use 'mattn/emmet-vim'

  -- Changes the working directory to the project root when you open a file.
  use 'airblade/vim-rooter'

  -- Automatically toggle relative line numbers based on mode.
  use 'kennykaye/vim-relativity'

  -- Comment code with gc{motion}, gcc, etc.
  use {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end
  }

  -- Highlight and search for todo comments like TODO, HACK, BUG
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup()
    end
  }

  -- Sets the commentstring option based on the cursor location in the file via treesitter queries.
  -- Useful when there are embedded languages in certain types of files.
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  --" Hex editor
  use 'Shougo/vinarise.vim'

  -- Automatically adjust shiftwidth and expandtab based on the current file
  use 'tpope/vim-sleuth'

  -- Easily add/delete/change 'surroundings': parentheses, brackets, quotes, XML
  -- tags, etc. [cs, ds, ys, yss]
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat' -- Make repeat with `.` command work for vim-surround

  -- ]q for :cnext. [q for :cprevious. ]a for :next. [b for :bprevious, etc.
  use 'tpope/vim-unimpaired'

  -- Add emacs key bindings to vim in insert and command-line modes.
  use 'maxbrunsfeld/vim-emacs-bindings'

  -- Show outdated crates in Cargo.toml
  use 'mhinz/vim-crates'

  -- Vim sugar for the UNIX shell commands that need it the most (:Delete,
  -- :Rename, :Mkdir, etc.)
  use 'tpope/vim-eunuch'

  -- Quickly switch between Angular files
  use 'softoika/ngswitcher.vim'

  -- Highlight hex and RGB colors in code
  use 'norcalli/nvim-colorizer.lua'

  -- Icons to use in the status bar
  use 'ryanoasis/vim-devicons'

  -- Adds more text objects to operate on like (), {}, [], <>, and t for tags.
  use 'wellle/targets.vim'

  -- Briefly highlight yanked text
  use 'machakann/vim-highlightedyank'

  -- Close buffers without closing windows and messing up the layout.
  use 'moll/vim-bbye'

  -- Adds the following:
  -- gS to split a one-liner into multiple lines
  -- gJ (with the cursor on the first line of a block) to join a block into a single-line statement
  use 'AndrewRadev/splitjoin.vim'

  -- Add :DeleteHiddenBuffers to remove background buffers
  use 'arithran/vim-delete-hidden-buffers'

  -- Internal modeline support allows all sorts of annoying and potentially insecure options to be set.
  -- This plugin implements a more heavily restricted version.
  use 'ciaranm/securemodelines'

  -- Adds indentation guides to all lines (including empty lines).
  use 'lukas-reineke/indent-blankline.nvim'

  -- Sessions
  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {}
    end
  }
  use {
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('session-lens').setup {}
    end
  }

  -- Language plugins
  use 'jparise/vim-graphql'
  use 'cespare/vim-toml'
  use 'kchmck/vim-coffee-script'
  use 'mustache/vim-mustache-handlebars'
  use 'tpope/vim-rails'
  use 'fladson/vim-kitty' -- kitty.conf
end)
