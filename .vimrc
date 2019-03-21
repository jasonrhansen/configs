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

Plug 'prabirshrestha/async.vim' "Used by vim-lsp
Plug 'prabirshrestha/vim-lsp' "Language Server Protocol
Plug 'ncm2/ncm2-vim-lsp'

" Gutentags is currently having issues with neovim
if !has('nvim')
  Plug 'ludovicchabant/vim-gutentags'
endif

Plug 'mattn/webapi-vim'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'PeterRincker/vim-argumentative'
" Snippets engine
Plug 'SirVer/ultisnips'
" Snippets used by snippets engine
Plug 'honza/vim-snippets'
Plug 'ncm2/ncm2-ultisnips'
Plug 'chrisbra/Recover.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'edkolev/tmuxline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'kennykaye/vim-relativity'
Plug 'rhysd/vim-clang-format'
Plug 'tomtom/tcomment_vim'
Plug 'vhdirk/vim-cmake'
" Automatically adjust shiftwidth and expandtab based on the current file
Plug 'tpope/vim-sleuth'
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
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Skim is a fuzzy finder written in Rust that's similar to fzf.
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
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
" GraphQL
Plug 'jparise/vim-graphql'
" Haskell
Plug 'lukerandall/haskellmode-vim'
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
" Python
Plug 'davidhalter/jedi-vim'           " Python autocompletion
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
" Typescript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
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

" Turn of search highlights by pressing return unless in quickfix window
nnoremap <expr> <cr> &buftype ==# 'quickfix' ? "\<CR>" : ':noh<cr>'

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

let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_set_highlights = 0
let g:ale_sign_column_always = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_delay = 0
let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_cargo_check_all_targets = 1

nmap <silent> L <Plug>(ale_lint)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    skim/fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" skim.vim is a fork of fzf.vim and is configured the same way
" except that it uses sk instead of fzf.

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
    " Close skim buffer with ESC
    autocmd! FileType skim tnoremap <buffer> <esc> <c-c>
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    gutentags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gutentags_cache_dir = "~/.gutentags"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             Language Server Protocal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" go get -u github.com/sourcegraph/go-langserver
if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
endif

" npm install -g typescript typescript-language-server
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript'],
        \ })
endif

" pip install python-language-server
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
        \ 'whitelist': ['rust'],
        \ })
endif

" gem install solargraph
if executable('solargraph')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

"npm install -g vscode-css-languageserver-bin
if executable('css-languageserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'whitelist': ['css', 'less', 'sass'],
        \ })
endif

"npm install -g flow-bin
if executable('flow')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'flow',
        \ 'cmd': {server_info->['flow', 'lsp']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
        \ 'whitelist': ['javascript', 'javascript.jsx'],
        \ })
endif

let g:lsp_diagnostics_enabled = 0 " disable diagnostics support since we're using ale
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode<Paste>

nnoremap <silent> K :LspHover<CR>
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> <F7> :LspReferences<CR>
nnoremap <silent> <F2> :LspRename<CR>
nnoremap <silent> <Leader>C :LspCodeAction<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

let g:lightline = {}

let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'gitbranch': 'fugitive#head',
      \ }

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

let g:lightline.active = {
      \ 'left': [['mode', 'paste'], ['readonly', 'filename', 'modified'], ['gitbranch']],
      \ 'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'], ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok']]
      \ }

let g:lightline.inactive = {
      \ 'left': [['filename']],
      \ 'right': [['lineinfo'], ['percent']]
      \ }


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
let g:go_addtags_transform = "snakecase"

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

