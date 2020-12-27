 " Whether to use unstable nvim-lsp. If set to 0, coc.nvim will be used.
let s:use_nvim_lsp = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()


if s:use_nvim_lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'nvim-treesitter/playground'
  " Plug 'nvim-treesitter/nvim-treesitter-textobjects'

  " Alternative to vim-gitgutter
  Plug 'mhinz/vim-signify'

  " Instead of coc-prettier
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

  Plug 'SirVer/ultisnips'

  " telescope.nvim (like fzf.vim, but relies on builtin LSP for some features)
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/telescope.nvim'
  PLug 'nvim-telescope/telescope-fzy-native.nvim'
else
  " Intellisense engine and full language server protocol Most language features
  " are coc.nvim extensions, see g:coc_global_extensions below.
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

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
Plug 'ntpeters/vim-better-whitespace'
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
" Fork of 'kyazdani42/nvim-tree.lua' that doesn't disable netrw.
Plug 'jasonrhansen/nvim-tree.lua'

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
set nocursorline " Cursorline slows down too much for some large files.
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
\    'Search': { 'attr': 'none', 'guifg': 'FFFFFF',  'guibg': '384048' },
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

let g:python_host_prog = "/usr/local/bin/python2.7"
let g:python3_host_prog = "/usr/local/bin/python3.9"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Custom Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easily grep for word or WORD under cursor
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:cw<cr>
nnoremap <leader>G :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:cw<cr>

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
"                   coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !s:use_nvim_lsp
  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K <cmd>call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction


  " Remap for rename current word
  nmap <silent> <leader>rn <Plug>(coc-rename)
  nmap <silent> <F2> <Plug>(coc-rename)

  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  " Format whole file
  nmap <leader>F <cmd>call CocAction('format')<cr>

  augroup vimrc
    autocmd!
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Setup formatexpr for specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Implement methods for trait
  nnoremap <silent> <space>i  <cmd>call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format <cmd>call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold <cmd>call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   <cmd>call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

  let g:coc_global_extensions = [
              \ 'coc-angular',
              \ 'coc-css',
              \ 'coc-eslint',
              \ 'coc-git',
              \ 'coc-go',
              \ 'coc-highlight',
              \ 'coc-html',
              \ 'coc-java',
              \ 'coc-json',
              \ 'coc-markdownlint',
              \ 'coc-pairs',
              \ 'coc-phpls',
              \ 'coc-prettier',
              \ 'coc-python',
              \ 'coc-rust-analyzer',
              \ 'coc-snippets',
              \ 'coc-solargraph',
              \ 'coc-svg',
              \ 'coc-tsserver',
              \ 'coc-tslint-plugin',
              \ 'coc-vimlsp',
              \ 'coc-xml',
              \ 'coc-yaml',
              \ 'coc-lua',
              \ ]

  " coc extension settings

  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)

  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)

  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'

  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'

  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)

  augroup vimrc
    autocmd FileType rust let b:coc_pairs_disabled = ['''']
    autocmd FileType markdown let b:coc_pairs_disabled = ['`']
    autocmd FileType vim let b:coc_pairs_disabled = ['"']
  augroup end

  " Make coc-pairs work well with <cr>
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !s:use_nvim_lsp

  " Customize Rg command to not search filenames. I only want it to search file contents.
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1,
    \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

  " Add another ripgrep command "RG", that doesn't use fzf for fuzzy matching. Each time the query string changes, ripgrep is called.
  " fzf only acts as a simple selector interface.
  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction
  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  nnoremap [fzf] <nop>
  " fzf prefix key
  nmap t [fzf]

  if executable('rg')
      nnoremap [fzf]r :Rg<cr>
  endif

  nnoremap [fzf]b :Buffers<cr>
  nnoremap [fzf]c :Commands<cr>
  nnoremap [fzf]l :BLines<cr>
  nnoremap [fzf]L :Lines<cr>
  nnoremap [fzf]m :Marks<cr>
  nnoremap [fzf]P :Files<cr>
  nnoremap [fzf]p :GFiles<cr>
  nnoremap [fzf]s :Snippets<cr>
  nnoremap [fzf]t :BTags<cr>
  nnoremap [fzf]T :Tags<cr>
  nnoremap [fzf]g :BCommits<cr>
  nnoremap [fzf]G :Commits<cr>
  nnoremap [fzf]h :History<cr>
  nnoremap [fzf]/ :History/<cr>
  nnoremap [fzf]: :History:<cr>
  nnoremap [fzf]H :Helptags<cr>
  nnoremap [fzf]M :Maps<cr>
  "
  " Mapping selecting mappings
  nmap [fzf]<tab> <plug>(fzf-maps-n)
  xmap [fzf]<tab> <plug>(fzf-maps-x)
  omap [fzf]<tab> <plug>(fzf-maps-o)

  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  " Replace the default dictionary completion with fzf-based fuzzy completion
  inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

  augroup vimrc
      " Close fzf buffer with ESC
      autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
  augroup END

  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')

    let height = &lines - 3
    let width = float2nr(&columns - (&columns * 2 / 10))
    let col = float2nr((&columns - width) / 2)

    let opts = {
          \ 'relative': 'editor',
          \ 'row': 1,
          \ 'col': col,
          \ 'width': width,
          \ 'height': height
          \ }

    call nvim_open_win(buf, v:true, opts)
  endfunction

  let $FZF_DEFAULT_OPTS='--layout=reverse'
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }

  let g:fzf_colors = {'bg': ['bg', 'Normal']}
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

function! Status() abort
  if s:use_nvim_lsp
    return LspStatus()
  else
    return coc#status()
  endif
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
      \ 'currentfunction': 'CurrentFunction',
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
"                    ngswitcher
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>nt <cmd>NgSwitchTS<CR>
nnoremap <leader>nc <cmd>NgSwitchCSS<CR>
nnoremap <leader>nh <cmd>NgSwitchHTML<CR>
nnoremap <leader>ns <cmd>NgSwitchSpec<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   nvim-tree.lua
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lua_tree_side = 'left' "left by default
let g:lua_tree_size = 40 "30 by default
let g:lua_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:lua_tree_auto_open = 0 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:lua_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:lua_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:lua_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:lua_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:lua_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:lua_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:lua_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \}
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath

" You can edit keybindings be defining this variable
" You don't have to define all keys.
" NOTE: the 'edit' key will wrap/unwrap a folder and open a file
let g:lua_tree_bindings = {
    \ 'edit':            ['<CR>', 'o'],
    \ 'edit_vsplit':     '<C-v>',
    \ 'edit_split':      '<C-x>',
    \ 'edit_tab':        '<C-t>',
    \ 'toggle_ignored':  'I',
    \ 'toggle_dotfiles': '.',
    \ 'preview':         '<C-p>',
    \ 'cd':              '<C-]>',
    \ 'create':          'a',
    \ 'remove':          'd',
    \ 'rename':          'r',
    \ 'cut':             'x',
    \ 'copy':            'c',
    \ 'paste':           'p',
    \ 'prev_git_item':   '[c',
    \ 'next_git_item':   ']c',
    \}

" Disable default mappings by plugin
" Bindings are enable by default, disabled on any non-zero value
" let lua_tree_disable_keybindings=1

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:lua_tree_icons = {
    \ 'default': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': ""
    \   }
    \ }

nnoremap <leader>e :LuaTreeToggle<CR>
nnoremap <leader>r :LuaTreeRefresh<CR>
nnoremap <leader>n :LuaTreeFindFile<CR>

set termguicolors " this variable must be enabled for colors to be applied properly

augroup vimrc
    autocmd FileType LuaTree set nowrap
    autocmd FileType LuaTree nnoremap <buffer><leader>w :set nowrap!<CR>
augroup END


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
"             vim-better-whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>t  :StripWhitespace<CR>


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
"                   nvim-lsp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if s:use_nvim_lsp
  lua require 'init'

  " Use completion-nvim in every buffer
  autocmd BufEnter * lua require'completion'.on_attach()

  let g:completion_enable_snippet = 'UltiSnips'
  imap <silent> <c-space> <Plug>(completion_trigger)
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsExpandTrigger="<c-j>"

  inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

  " Set completeopt to have a better completion experience
  set completeopt=menuone,noinsert,noselect

  let g:signify_sign_change = '~'
endif
