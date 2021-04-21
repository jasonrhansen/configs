""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'glepnir/lspsaga.nvim'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Alternative to vim-gitgutter
Plug 'mhinz/vim-signify'

" Instead of coc-prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'kana/vim-altercmd'
Plug 'ciaranm/securemodelines'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-rooter'
" Snippets used by snippets engine
Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'edkolev/tmuxline.vim'
Plug 'kennykaye/vim-relativity'
Plug 'tomtom/tcomment_vim'
Plug 'vhdirk/vim-cmake'
" Automatically adjust shiftwidth and expandtab based on the current file
Plug 'tpope/vim-sleuth'
"" Hex editor
Plug 'Shougo/vinarise.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/camelcasemotion'
Plug 'wellle/targets.vim'
" Use this version instead of vim-scripts/a.vim because it
" won't create imaps by default.
Plug 'fanchangyong/a.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'moll/vim-bbye'
Plug 'AndrewRadev/splitjoin.vim'
" Add emacs key bindings to vim in insert and command-line modes.
Plug 'maxbrunsfeld/vim-emacs-bindings'
" Show outdated crates in Cargo.toml
Plug 'mhinz/vim-crates'
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
Plug 'tpope/vim-git'
Plug 'jparise/vim-graphql'
Plug 'groenewege/vim-less', { 'for': 'Less' }
Plug 'wlangstroth/vim-racket'
Plug 'toyamarinyon/vim-swift', { 'for': 'swift' }
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
Plug 'cespare/vim-toml'
" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rhysd/committia.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'mustache/vim-mustache-handlebars'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'tpope/vim-rails'
" Vim sugar for the UNIX shell commands that need it the most (:Delete,
" :Rename, :Mkdir, etc.)
Plug 'tpope/vim-eunuch'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ryanoasis/vim-devicons'

" Expand abbreviations for HTML like 'div>p#foo$*3>a' with '<c-y>,'
Plug 'mattn/emmet-vim'

" Color theme
Plug 'nanotech/jellybeans.vim'

" File manager
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Quickly switch between Angular files
Plug 'softoika/ngswitcher.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Reset vimrc augroup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reset the vimrc augroup. Autocommands are added to this group throughout.
augroup vimrc
    autocmd!
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved
syntax on
filetype plugin on
filetype indent on
let mapleader="\<SPACE>"
let maplocalleader="-"

set hidden
set wildmenu
set wildmode=longest,list,full
set wildignorecase
set showfulltag
set history=1000
set ignorecase
set smartcase
set title
set scrolloff=3
set ruler
set backspace=indent,eol,start
set incsearch
set wildchar=<Tab>
set foldmethod=marker
set textwidth=0
set undolevels=1000
set showcmd
set showmatch
set number
set cursorline
" Update syntax highlighting for more lines increased scrolling performance
syntax sync minlines=256
set autoread
set background=dark
" Remove menu bar
set guioptions-=m
" Remove toolbar
set guioptions-=T
let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr
set nolist
set listchars=tab:▸\              " Char representing a tab
set listchars+=extends:❯          " Char representing an extending line
set listchars+=nbsp:␣             " Non breaking space
set listchars+=precedes:❮         " Char representing an extending line in the other direction
set linebreak                       " Break properly, don't split words
set scrolloff=4                     " Show context above/below cursorline
set formatoptions+=j
set sidescrolloff=5
set shiftround
set nostartofline
set laststatus=2
set noerrorbells
set visualbell
set secure
set nomodeline                      " Use securemodelines instead
set noshowmode                      " Lightline shows the mode

" indentation
set expandtab                     " Indent with spaces
set shiftwidth=2                  " Number of spaces to use when indenting
set smartindent                   " Auto indent new lines
set softtabstop=2                 " Number of spaces a <tab> counts for when inserting
set tabstop=2                     " Number of spaces a <tab> counts for

" Session and view options to save
set sessionoptions=buffers,folds,tabpages,curdir,globals
set viewoptions=cursor,folds

" This feels more natural
set splitbelow
set splitright

set undofile
set nobackup
set nowritebackup
set noswapfile

set undodir=~/.vim/tmp/undo//           " undo files

set mouse=a                             " Enable mouse in all modes
set mousemodel=popup_setpos             " Right-click on selection should bring up a menu
if !has('nvim')
  set ttymouse=xterm2                   " Needed to be able to resize panes with mouse
endif

set pastetoggle=<F2>

" Still show syntax highlighting for really large files.
set redrawtime=10000

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

augroup vimrc
    " Automatically rebalance windows on vim resize
    autocmd VimResized * :wincmd =
augroup END

"  Color preferences
if !has('gui_running')
  set t_Co=256
endif
if (exists('$TMUX') && system('tmux show-env TERMINAL_THEME') == "TERMINAL_THEME=light\n") || $TERMINAL_THEME == "light"
    set background=light
else
    set background=dark
endif


let base16colorspace=256
let g:jellybeans_use_term_italics = 1
let g:jellybeans_overrides = {
\    'DiffAdd': { 'guifg': '65C254', 'guibg': '121212' },
\    'DiffChange': { 'guifg': '2B8BF7', 'guibg': '121212' },
\    'DiffDelete': { 'guifg': '902020', 'guibg': '121212' },
\    'SignColumn': { 'guibg': '121212' },
\    'Pmenu': { 'ctermbg': '236', 'guibg': '333333' },
\    'Search': { 'attr': 'none', 'guifg': 'FFFFFF', 'guibg': '384048' },
\    'Normal': { 'guibg': '121212' },
\    'LineNr': { 'guibg': '121212' },
\    'NonText': { 'guibg': '121212' },
\    'Constant': { 'guifg': '7697D6' },
\}
colorscheme jellybeans

set fillchars=vert:\ ,

" Cursor configuration
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"

if has('unnamedplus')
    " By default, Vim will not use the system clipboard when yanking/pasting to
    " the default register. This option makes Vim use the system default
    " clipboard.
    " Note that on X11, there are _two_ system clipboards: the 'standard' one, and
    " the selection/mouse-middle-click one. Vim sees the standard one as register
    " '+' (and this option makes Vim use it by default) and the selection one as
    " '*'.
    " See :h 'clipboard' for details.
    set clipboard=unnamedplus,unnamed
else
    " Vim now also uses the selection system clipboard for default yank/paste.
    set clipboard+=unnamed
endif

set encoding=utf-8

" Don't use clipboard over ssh since it makes vim load too slowly.
if !has("gui_running") && !has("nvim")
    let g:display_num =
                \ substitute(
                \ substitute( $DISPLAY , "^[[:alpha:]]*:" , "" , "" ) ,
                \ "\.[[:digit:]]*$" , "" , "" )
    if ( g:display_num >= 10 )
        set clipboard=exclude:.*
    endif
endif

" Automatically set tmux window name
if exists('$TMUX') && !exists('$NORENAME')
  augroup vimrc
    autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  augroup END
endif

let g:python_host_prog = system('which python2.7')
let g:python3_host_prog = system('which python3.9')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Custom Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Turn off search highlights by pressing return unless in quickfix window
nnoremap <expr> <cr> &buftype ==# 'quickfix' ? "\<CR>" : ':noh<cr>'

" Escape is too much of a reach. Use jk to exit insert mode and command mode.
inoremap jk <esc>
cnoremap jk <c-e><c-u><esc>
" Also c-k works well for this
inoremap <c-k> <esc>
cnoremap <c-k> <c-e><c-u><esc>

" Make editing and sourcing .vimrc really easy.
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" Add a 'stamp' command to replace word or selection with yanked text.
nnoremap S diw"0P
vnoremap S "_d"0P

" Make "Y" work from the cursor to end of line instead of like "yy"
nnoremap Y y$

" Fast saving
nnoremap <leader>w :w!<cr>

" Reselect visual selection after indent
xnoremap < <gv
xnoremap > >gv

" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
cnoremap w!! w !sudo tee % >/dev/null

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Also center the screen when jumping through the changelist
nnoremap g; g;zz
nnoremap g, g,z

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

" With this map, we can select some text in visual mode and by invoking the map,
" have the selection automatically filled in as the search text and the cursor
" placed in the position for typing the replacement text. Also, this will ask
" for confirmation before it replaces any instance of the search text in the
" file.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" This makes j and k work on "screen lines" instead of on "file lines"; now, when
" we have a long line that wraps to multiple screen lines, j and k behave as we
" expect them to.
nnoremap j gj
nnoremap k gk

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Move between buffers faster
nnoremap <silent> <C-b> :silent :bp<CR>
nnoremap <silent> <C-n> :silent :bn<CR>

" Switch between source and header files with a.vim
nmap <leader>h :A<cr>

" Resize windows with the arrow keys and shift key
nnoremap <s-up> 10<C-W>+
nnoremap <s-down> 10<C-W>-
nnoremap <s-left> 3<C-W><
nnoremap <s-right> 3<C-W>>

" Exit insert mode and save just by hitting CTRL-s
imap <c-s> <esc>:w<cr>
nmap <c-s> <esc>:w<cr>

" Toggle list chars with F3
noremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>
cnoremap <F3> <C-c>:set list!<CR>

if has('nvim')
    " Make working with nvim terminal emulator nicer
    tnoremap <esc> <c-\><c-n>
    tnoremap <c-h> <c-\><c-n><c-w>h
    tnoremap <c-j> <c-\><c-n><c-w>j
    tnoremap <c-k> <c-\><c-n><c-w>k
    tnoremap <c-l> <c-\><c-n><c-w>l
    augroup vimrc
        " Don't show line numbers in terminal
        autocmd BufWinEnter,WinEnter term://* set nonumber
        " Always put terminal in insert mode on enter
        autocmd BufWinEnter,WinEnter term://* startinsert
    augroup END

    " Don't let relativity handle line numbers in terminal
    let g:relativity_buftype_ignore = ['nofile', 'terminal']

    set inccommand=nosplit
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                Plugin Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc
    " Allow .md extension to be recognized as markdown
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

augroup vimrc
    " Start git commits in insert mode
    autocmd FileType gitcommit startinsert
    autocmd FileType gitcommit set colorcolumn=80
augroup END

nnoremap <Leader>q :Bdelete<CR>

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

function! Status() abort
  return LspStatus()
endfunction

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function GitBranch()
  return ' ' . fugitive#head()
endfunction

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'gitbranch': 'GitBranch',
      \ 'status': 'Status',
      \ 'sleuth': 'SleuthIndicator',
      \ 'filetype': 'MyFiletype',
      \ 'fileformat': 'MyFileformat',
      \ }


let g:lightline.active = {
      \ 'left': [['mode', 'paste'], ['readonly', 'filename', 'modified'], ['gitbranch'], ['status']],
      \ 'right': [['lineinfo'], ['percent'], ['filetype', 'fileformat', 'fileencoding', 'sleuth']]
      \ }

let g:lightline.inactive = {
      \ 'left': [['filename']],
      \ 'right': [['lineinfo'], ['percent']]
      \ }

augroup vimrc
  " Use autocmd to force lightline update.
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  lsp_extensions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vimrc
  " Type hints for Rust
  autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
        \ :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "NonText", enabled = {"ChainingHint"} }
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    ngswitcher
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>nt <cmd>NgSwitchTS<CR>
nnoremap <leader>nc <cmd>NgSwitchCSS<CR>
nnoremap <leader>nh <cmd>NgSwitchHTML<CR>
nnoremap <leader>ns <cmd>NgSwitchSpec<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Tabular
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Looks at the current line and the lines above and below it and aligns all the
" equals signs. Useful for when we have several lines of declarations.
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a/ :Tabularize /\/\//l2c1l0<CR>
vnoremap <Leader>a/ :Tabularize /\/\//l2c1l0<CR>
nnoremap <Leader>a, :Tabularize /,/l0r1<CR>
vnoremap <Leader>a, :Tabularize /,/l0r1<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 vim-crates
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   vinarise
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Detect binary file or large file automatically
let g:vinarise_enable_auto_detect = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   vim-signify
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:signify_sign_change = '~'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   vim-vsnip
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Expand or jump
imap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
smap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'

" Jump forward or backward
imap <expr> <c-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<c-k>'
smap <expr> <c-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<c-k>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             LUA Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua require 'lsp_config'
lua require 'telescope_config'
lua require 'compe_config'
lua require 'lspsaga_config'
lua require 'nvim_tree_config'
" lua require 'treesitter_config'
