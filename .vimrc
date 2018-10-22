""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                  Plugins
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/bundle')

Plug 'ciaranm/securemodelines'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-rooter'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'

" Semantic language support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'mattn/webapi-vim'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'Shougo/echodoc.vim'

Plug 'Lokaltog/vim-easymotion'
Plug 'PeterRincker/vim-argumentative'
Plug 'SirVer/ultisnips'               " Snippets engine
Plug 'honza/vim-snippets'             " Snippets used by snippets engine
Plug 'davidhalter/jedi-vim'           " Python autocompletion
Plug 'chrisbra/Recover.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'edkolev/tmuxline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'justinmk/vim-gtfo'
Plug 'lukerandall/haskellmode-vim'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'kennykaye/vim-relativity'
Plug 'rhysd/vim-clang-format'
Plug 'rstacruz/sparkup'
Plug 'scrooloose/nerdcommenter'
Plug 'vhdirk/vim-cmake'
" Automatically adjust shiftwidth and expandtab based on the current file
Plug 'tpope/vim-sleuth'
function! BuildVimProc(info)
    if has('win32') || has('win64')
        !tools\\update-dll-mingw 32
    else
        !make
    endif
endfunction
Plug 'Shougo/vimproc.vim', { 'do': function('BuildVimProc') }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
"" Hex editor
Plug 'Shougo/vinarise.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/camelcasemotion'
Plug 'wellle/targets.vim'
" Use this version instead of vim-scripts/a.vim because it
" won't create imaps by default.
Plug 'fanchangyong/a.vim'
Plug 'chriskempson/base16-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'AndrewRadev/splitjoin.vim'

" Add emacs key bindings to vim in insert and command-line modes.
Plug 'maxbrunsfeld/vim-emacs-bindings'

" C/C++/ObjC
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp', 'objc'] }
Plug 'vim-jp/cpp-vim', { 'for': ['c', 'cpp', 'objc'] }
" CSV
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" Git
Plug 'tpope/vim-git'
" Go
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'rhysd/vim-go-impl', { 'for': 'go' }
" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" HTML/CSS/SCSS
Plug 'JulesWang/css.vim', { 'for': ['css', 'html', 'html5', 'less'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'html', 'html5', 'less', 'scss'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'html', 'html5', 'less'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }
Plug 'othree/html5.vim', { 'for': ['css', 'html', 'html5'] }
" Javascript/CoffeeScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'matthewsimo/angular-vim-snippets'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'kchmck/vim-coffee-script'
" JSON
Plug 'leshill/vim-json'
" Less
Plug 'groenewege/vim-less', { 'for': 'Less' }
" Markdown
Plug 'plasticboy/vim-markdown'
" Ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-bundler'
" Rust
Plug 'rust-lang/rust.vim'
" Scheme - Racket dialect
Plug 'wlangstroth/vim-racket'
" Swift
Plug 'toyamarinyon/vim-swift', { 'for': 'swift' }
" Tmux syntax
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
" Vimscript
Plug '~/dev/projects/api-soup', {'rtp': 'vim-syntax/'}
" TOML
Plug 'cespare/vim-toml'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                 Reset vimrc augroup
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Reset the vimrc augroup. Autocommands are added to this group throughout.
augroup vimrc
    autocmd!
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                 General Settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We store some config files and snippets here and the
" whole dotfiles dir is a git repo. Should be the last entry in rtp (for
" UltiSnips).
set rtp+=$HOME/dotfiles/vim

set nocompatible              " be iMproved
syntax on
filetype plugin on
filetype indent on
let mapleader="\<SPACE>"
let maplocalleader="-"

set hidden
set wildmenu
set wildmode=list:full
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
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set wildchar=<Tab>
set foldmethod=marker
set textwidth=0
set undolevels=1000
set showcmd
set showmatch
set number
set cursorline
set synmaxcol=1000
" Update syntax highlighting for more lines increased scrolling performance
syntax sync minlines=256
set autoread
set cpoptions+=$
set background=dark
" Remove menu bar
set guioptions-=m
" Remove toolbar
set guioptions-=T
let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr
set listchars=tab:\ \ ,trail:▫      " Characters to use for whitespace when set list
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

" Session and view options to save
set sessionoptions=buffers,folds,tabpages,curdir,globals
set viewoptions=cursor,folds

" This feels more natural
set splitbelow
set splitright

set undofile
set backup
set swapfile

set undodir=~/.vim/tmp/undo//           " undo files
set backupdir=~/.vim/tmp/backup//       " backups
set directory=~/.vim/tmp/swap//         " swap files

set mouse=a                             " Enable mouse in all modes
set mousemodel=popup_setpos             " Right-click on selection should bring up a menu
if !has('nvim')
  set ttymouse=xterm2                   " Needed to be able to resize panes with mouse
endif

set pastetoggle=<F2>

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

augroup vimrc
    " Automatically rebalance windows on vim resize
    autocmd VimResized * :wincmd =
augroup END

" Color scheme preferences
if (exists('$TMUX') && system('tmux show-env TERMINAL_THEME') == "TERMINAL_THEME=light\n") || $TERMINAL_THEME == "light"
    set background=light
else
    set background=dark
endif
let base16colorspace=256
colorscheme base16-atelier-dune

" Cursor configuration
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
let &t_SI                         = "\<Esc>[5 q"
let &t_SR                         = "\<Esc>[3 q"
let &t_EI                         = "\<Esc>[2 q"

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

if !has('nvim')
    set encoding=utf-8
endif

if has("gui_running")
    set lines=50
    set columns=150
    set guifont=DejaVu_Sans_Mono_for_Powerline_Nerd_Font_Complete_Mono:h12
    set linespace=2
    set guioptions-=r
    set guioptions-=e
    set guioptions-=L
endif

if has('win32')
    set guifont=DejaVu_Sans_Mono_for_Powerline:h9:cANSI
endif

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                 Custom Mappings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Easily grep for word or WORD under cursor
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:cw<cr>
nnoremap <leader>G :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:cw<cr>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Make it easier to enter commands by just pressing enter.
nnoremap <cr> :

" Use backspace to toggle between current file and previous file
nnoremap <bs> <c-^>

" Escape is too much of a reach. Use jk to exit insert mode and command mode.
inoremap jk <esc>
cnoremap jk <c-e><c-u><esc>

" Make editing and sourcing .vimrc really easy.
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

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

" Keep search matches in the middle of the window.
" zz centers the screen on the cursor, zv unfolds any fold if the cursor
" suddenly appears inside a fold.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv<silent> zk O<Esc>j

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

if has('nvim')
    " Make working with nvim terminal emulator nicer
    tnoremap <esc> <c-\><c-n>
    tnoremap jk    <c-\><c-n>
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

" Toggle between light and dark version of theme
noremap <F6> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

augroup vimrc
    " Reload vimrc after saving
    autocmd BufWritePost $MYVIMRC,.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim source %
augroup END

augroup ruby_group
    autocmd!
    autocmd FileType ruby,eruby nmap gd g<C-]>
	autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
    autocmd filetype ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd filetype ruby,eruby let g:rubycomplete_rails = 1
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"                Plugin Configuration
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime macros/matchit.vim
let g:used_javascript_libs='jquery,angularjs'

" Automatically format C++ code on save
let g:clang_format#auto_format = 1

augroup vimrc
    " Allow .md extension to be recognized as markdown
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

" Fix problem in auto-pairs where adding an if or for around an existing
" block of code and trying to close the brace would jump to the function
" closing brace.
let g:AutoPairsMultilineClose = 0

" For haskell documentation
let g:haddock_browser="/usr/bin/google-chrome-beta"

" Haskell compiler plugin
augroup vimrc
    autocmd BufEnter *.hs compiler ghc
augroup END

augroup vimrc
    " Start git commits in insert mode
    autocmd FileType gitcommit startinsert
    autocmd FileType gitcommit set colorcolumn=80
augroup END

nnoremap <Leader>q :Bdelete<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_cargo_check_all_targets = 1

nmap <silent> L <Plug>(ale_lint)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  EasyMotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <leader>em <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-s)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap [fzf] <nop>
" fzf prefix key
nmap t [fzf]

if executable('ag')
    nnoremap [fzf]a :Ag<cr>
endif

nnoremap [fzf]b :Buffers<cr>
nnoremap [fzf]c :Commands<cr>
nnoremap [fzf]l :BLines<cr>
nnoremap [fzf]L :Lines<cr>
nnoremap [fzf]m :Marks<cr>
nnoremap [fzf]p :Files<cr>
nnoremap [fzf]s :Snippets<cr>
nnoremap [fzf]t :BTags<cr>
nnoremap [fzf]T :Tags<cr>
nnoremap [fzf]g :BCommits<cr>
nnoremap [fzf]G :Commits<cr>
nnoremap [fzf]h :History<cr>
nnoremap [fzf]/ :History/<cr>
nnoremap [fzf]: :History:<cr>
nnoremap [fzf]w :Windows<cr>
nnoremap [fzf]H :Helptags<cr>
nnoremap [fzf]M :Maps<cr>

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

augroup vimrc
    " Close fzf buffer with ESC
    autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Gutentags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Save all tag files in one directory so they don't pollute the project dirs
"let g:gutentags_cache_dir = $HOME.'/.gutentags_cache'
"if !isdirectory(g:gutentags_cache_dir)
    "call mkdir(g:gutentags_cache_dir,"p")
"endif

"" Allow debugging/troubleshooting commands
"let g:gutentags_define_advanced_commands=1

"set statusline+=%{gutentags#statusline()}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             Language Server Protocal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'], 
    \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <Leader>C :call LanguageClient#textDocument_codeAction()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
\ }

function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 'right': [[ 'filename', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     ncm2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> pumvisible() ? "\<c-y>\<cr>" : "\<CR>"

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     rust.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Format rust code every time a buffer is saved
let g:rustfmt_autosave = 1


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
"                    UltiSnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsSnippetsDir   = $HOME . '/dotfiles/vim/UltiSnips'
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:snips_author           = 'Jason Rodney Hansen'
augroup UltiSnips_group
    autocmd!
    " UltiSnips is missing a setf trigger for snippets on BufEnter
    autocmd vimrc BufEnter *.snippets setf snippets
    " In UltiSnips snippet files, we want actual tabs instead of spaces for
    " indents. US will use those tabs and convert them to spaces if expandtab
    " is set when the user wants to insert the snippet.
    autocmd vimrc FileType snippets set noexpandtab
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             vim-better-whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>t  :StripWhitespace<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   vimfiler
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>f :VimFiler<CR>
nmap <leader>F :VimFiler -find<CR>
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
let g:vimfiler_ignore_pattern = '\.git\|\.DS_Store\|\.pyc'

" Some of the default keymappings conflict with other mappings
let g:vimfiler_no_default_key_mappings = 1

augroup vimfiler_group
    autocmd!

    " Toggle safe mode
    autocmd FileType vimfiler nmap <buffer><nowait>gs <Plug>(vimfiler_toggle_safe_mode)

    autocmd FileType vimfiler nmap <buffer><nowait>j <Plug>(vimfiler_loop_cursor_down)
    autocmd FileType vimfiler nmap <buffer><nowait>k <Plug>(vimfiler_loop_cursor_up)
    autocmd FileType vimfiler nmap <buffer><nowait><F5> <Plug>(vimfiler_redraw_screen)

    " Toggle mark
    autocmd FileType vimfiler nmap <buffer><nowait><Space> <Plug>(vimfiler_toggle_mark_current_line)
    autocmd FileType vimfiler nmap <buffer><nowait><S-LeftMouse> <Plug>(vimfiler_toggle_mark_current_line)
    autocmd FileType vimfiler vmap <buffer><Space> <Plug>(vimfiler_toggle_mark_selected_lines)

    " Toggle marks all lines
    autocmd FileType vimfiler nmap <buffer><nowait>* <Plug>(vimfiler_toggle_mark_all_lines)
    autocmd FileType vimfiler nmap <buffer><nowait># <Plug>(vimfiler_mark_similar_lines)
    autocmd FileType vimfiler nmap <buffer><nowait>U <Plug>(vimfiler_clear_mark_all_lines)

    "Copy files
    autocmd FileType vimfiler nmap <buffer><nowait>c <Plug>(vimfiler_copy_file)
    autocmd FileType vimfiler nmap <buffer><nowait>Cc <Plug>(vimfiler_clipboard_copy_file)

    " Move files
    autocmd FileType vimfiler nmap <buffer><nowait>m <Plug>(vimfiler_move_file)
    autocmd FileType vimfiler nmap <buffer><nowait>Cm <Plug>(vimfiler_clipboard_move_file)

    " Delete files
    autocmd FileType vimfiler nmap <buffer><nowait>d <Plug>(vimfiler_delete_file)

    " Rename
    autocmd FileType vimfiler nmap <buffer><nowait>r <Plug>(vimfiler_rename_file)

    " Make directory
    autocmd FileType vimfiler nmap <buffer><nowait>K <Plug>(vimfiler_make_directory)

    " New file
    autocmd FileType vimfiler nmap <buffer><nowait>N <Plug>(vimfiler_new_file)

    " Paste
    autocmd FileType vimfiler nmap <buffer><nowait>Cp <Plug>(vimfiler_clipboard_paste)

    " Edit file or change directory
    autocmd FileType vimfiler nmap <buffer><nowait><Return> <Plug>(vimfiler_cd_or_edit)
    autocmd FileType vimfiler nmap <buffer><nowait>o <Plug>(vimfiler_expand_or_edit)
    autocmd FileType vimfiler nmap <buffer><nowait>l <Plug>(vimfiler_smart_l)

    " Execute file
    autocmd FileType vimfiler nmap <buffer><nowait>x <Plug>(vimfiler_execute_system_associated)

    " Navigate directories
    autocmd FileType vimfiler nmap <buffer><nowait>h <Plug>(vimfiler_smart_h)
    autocmd FileType vimfiler nmap <buffer><nowait>L <Plug>(vimfiler_switch_to_drive)
    autocmd FileType vimfiler nmap <buffer><nowait>~ <Plug>(vimfiler_switch_to_home_directory)
    autocmd FileType vimfiler nmap <buffer><nowait><leader>/ <Plug>(vimfiler_switch_to_root_directory)
    autocmd FileType vimfiler nmap <buffer><nowait>& <Plug>(vimfiler_switch_to_project_directory)
    autocmd FileType vimfiler nmap <buffer><nowait><BS> <Plug>(vimfiler_switch_to_parent_directory)

    autocmd FileType vimfiler nmap <buffer><nowait>. <Plug>(vimfiler_toggle_visible_dot_files)

    " Edit file
    autocmd FileType vimfiler nmap <buffer><nowait>e <Plug>(vimfiler_edit_file)
    autocmd FileType vimfiler nmap <buffer><nowait>E <Plug>(vimfiler_split_edit_file)
    autocmd FileType vimfiler nmap <buffer><nowait>B <Plug>(vimfiler_edit_binary_file)

    " Choose action
    autocmd FileType vimfiler nmap <buffer><nowait>a <Plug>(vimfiler_choose_action)

    " Hide vimfiler
    autocmd FileType vimfiler nmap <buffer><nowait>q <Plug>(vimfiler_hide)

    " Exit vimfiler
    autocmd FileType vimfiler nmap <buffer><nowait>Q <Plug>(vimfiler_exit)

    " Close vimfiler
    autocmd FileType vimfiler nmap <buffer><nowait>- <Plug>(vimfiler_close)

    autocmd FileType vimfiler nmap <buffer><nowait>! <Plug>(vimfiler_execute_shell_command)
    autocmd FileType vimfiler nmap <buffer><nowait>v <Plug>(vimfiler_preview_file)
    autocmd FileType vimfiler nmap <buffer><nowait><C-g> <Plug>(vimfiler_print_filename)
    autocmd FileType vimfiler nmap <buffer><nowait>yy <Plug>(vimfiler_yank_full_path)
    autocmd FileType vimfiler nmap <buffer><nowait>M <Plug>(vimfiler_set_current_mask)
    autocmd FileType vimfiler nmap <buffer><nowait>gr <Plug>(vimfiler_grep)
    autocmd FileType vimfiler nmap <buffer><nowait>gf <Plug>(vimfiler_find)
    autocmd FileType vimfiler nmap <buffer><nowait>S <Plug>(vimfiler_select_sort_type)
    autocmd FileType vimfiler nmap <buffer><nowait><C-v> <Plug>(vimfiler_switch_vim_buffer_mode)
    autocmd FileType vimfiler nmap <buffer><nowait>gc <Plug>(vimfiler_cd_vim_current_dir)
    autocmd FileType vimfiler nmap <buffer><nowait>gS <Plug>(vimfiler_toggle_simple_mode)
    autocmd FileType vimfiler nmap <buffer><nowait>gg <Plug>(vimfiler_cursor_top)
    autocmd FileType vimfiler nmap <buffer><nowait>G <Plug>(vimfiler_cursor_bottom)
    autocmd FileType vimfiler nmap <buffer><nowait>t <Plug>(vimfiler_expand_tree)
    autocmd FileType vimfiler nmap <buffer><nowait>T <Plug>(vimfiler_expand_tree_recursive)
    autocmd FileType vimfiler nmap <buffer><nowait>I <Plug>(vimfiler_cd_input_directory)
    autocmd FileType vimfiler nmap <buffer><nowait><2-LeftMouse> <Plug>(vimfiler_double_click)

    " pushd/popd
    autocmd FileType vimfiler nmap <buffer><nowait>Y <Plug>(vimfiler_pushd)
    autocmd FileType vimfiler nmap <buffer><nowait>P <Plug>(vimfiler_popd)

    autocmd FileType vimfiler nmap <buffer><nowait>gj <Plug>(vimfiler_jump_last_child)
    autocmd FileType vimfiler nmap <buffer><nowait>gk <Plug>(vimfiler_jump_first_child)

augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup go_group
    autocmd!
    autocmd FileType go nmap <Leader>i <Plug>(go-import)

    autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)
    autocmd FileType go nmap <leader>gr <Plug>(go-run)
    autocmd FileType go nmap <leader>gb <Plug>(go-build)
    autocmd FileType go nmap <leader>gt <Plug>(go-test)
    autocmd FileType go nmap <leader>gc <Plug>(go-coverage)

    autocmd FileType go nmap <leader>r <Plug>(go-rename)
    autocmd FileType go nmap <leader>n <Plug>(go-callees)

    autocmd FileType go nmap gd <Plug>(go-def)
    autocmd FileType go nmap <K> <Plug>(go-doc)

    autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
    autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
    autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
augroup END

let g:go_fmt_command = 'goimports'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" Tagbar for Go. Requires gotags.
" go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   vinarise
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Detect binary file or large file automatically
let g:vinarise_enable_auto_detect = 1

