" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" PATHOGEN
" execute pathogen#infect()

filetype off
" VUNDLE
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:

" original repos on github
Bundle 'fatih/vim-go'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'Shougo/deoplete.nvim'
Bundle 'roxma/nvim-yarp'
Bundle 'roxma/vim-hug-neovim-rpc'
Bundle 'zchee/deoplete-go'
" Bundle 'wincent/command-t'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'scrooloose/syntastic.git'
Bundle 'scrooloose/nerdcommenter.git'
" Bundle 'joonty/vdebug.git'
Bundle 'tpope/vim-fugitive'
" Bundle 'shougo/vimproc'
Bundle 'godlygeek/tabular'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-easytags'
Bundle 'majutsushi/tagbar'
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-projectionist'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fireplace'
" Bundle 'vim-scripts/paredit.vim'
Bundle 'tpope/vim-sexp-mappings-for-regular-people'
Bundle 'guns/vim-sexp'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
" needs lein-cljfmt on classpath
Bundle 'venantius/vim-cljfmt' 
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'kannokanno/previm'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sheerun/vim-polyglot'

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = 'RO'
let g:NERDTreeNodeDelimiter = "\u00a0"

" Line numbers
set number

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <leader>n :call NumberToggle()<cr>

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" always status
set laststatus=2

" search highlighting
set incsearch
set hlsearch

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" No eof newline
set noeol
set binary

" tabs = spaces
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" deoplete
let g:deoplete#enable_at_startup = 1

" syntastic
"let g:syntastic_php_phpcs_args=['--report=csv']
"let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_checkers=['php']
let g:syntastic_javascript_checkers = ['eslint']


" remap leader to ,
let mapleader = ","

" <leader>w to open and activate new split
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>l :!php -l "%"<CR>
nnoremap <leader>u :!vendor/bin/phpunit "%" && read<CR>
nnoremap <leader>U :!vendor/bin/phpunit "tests/" && read<CR>
nnoremap <leader>f yw :!grep 'function <C-r>"' * -r<CR>
nnoremap <leader>r :set wrap<CR>
nnoremap <leader>R :set nowrap<CR>
nnoremap <leader>s :so $MYVIMRC<CR>

" ctrlp like command-t
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
nnoremap <leader>t :CtrlP .<CR>

nnoremap <C-j> :bprev<CR>
nnoremap <C-k> :bnext<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <S-D-CR> :only<CR>

nnoremap <leader>j :%!python -m json.tool<CR>

nnoremap <leader>T :NERDTreeTabsToggle<CR>
" yum
" colorscheme peachpuff
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
" Patch GitGutter
highlight GitGutterAddDefault guibg=#002b36
highlight GitGutterChangeDefault guibg=#002b36
highlight GitGutterDeleteDefault guibg=#002b36


" To have NERDTree never open on startup
let g:nerdtree_tabs_open_on_console_startup = 0

" don't put .sw? files everywhere
set bdir-=.
set bdir+=/tmp
set dir-=.
set dir+=/tmp

" let g:ycm_python_binary_path = '/usr/bin/python'
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_autoclose_preview_window_after_completion = 1

" vdebug port clash with fpm
if !exists('g:vdebug_options')
  let g:vdebug_options = {}
endif
let g:vdebug_options["port"] = 10123

" Broken down into easily includeable segments
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=%{fugitive#statusline()} "  Git Hotness
set statusline+=\ [%{&ff}/%Y]            " filetype
"set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=0
let g:syntastic_auto_loc_list=0
let g:syntastic_loc_list_height=5
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

let g:CommandTMaxFiles=50000
let g:CommandTTraverseSCM="pwd"
let g:CommandTFileScanner="find"

" Tags
" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./.tags;
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 1
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1
let g:easytags_auto_highlight = 0

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with ,B
nmap <silent> <leader>B :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
"
" let g:ycm_collect_identifiers_from_tags_files=1

hi clear SignColumn

" FileType specifics
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType json setlocal foldmethod=syntax

" large files
" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowrite (file is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite | else | set eventignore-=FileType | endif
  augroup END
endif

" Previm
let g:previm_open_cmd = 'default'

" clj
nnoremap <leader>e :Eval<cr>
nnoremap <leader>E :Eval 
nnoremap <leader>L :Require!<cr>

" go
let g:go_metalinter_autosave = 1
let g:go_fmt_command = "goimports"
set completeopt-=preview
nnoremap <leader>g iif err != nil {<cr>return nil, err<cr>}<cr>

" python
set pyxversion=3

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if has("macunix")
  let g:previm_open_cmd = 'open -a /Applications/Firefox.app/Contents/MacOS/firefox'
  " set rubydll=/usr/local/lib/libruby.2.3.dylib
  let g:ycm_python_binary_path = '/usr/local/bin/python'
  let g:deoplete#sources#go#gocode_binary = "/Users/rjones/go/bin/gocode"
elseif has("unix")
  let g:previm_open_cmd = 'firefox'
  let g:deoplete#sources#go#gocode_binary = "/home/rich/go/bin/gocode"
  set guioptions-=T
elseif has("win64")
  let g:previm_open_cmd = 'c:\\Program\ Files\ (x86)\\Firefox\\firefox'
endif