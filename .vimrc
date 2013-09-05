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
Bundle 'Lokaltog/vim-easymotion'
Bundle 'git://github.com/Valloric/YouCompleteMe.git'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'Lokaltog/vim-powerline'
Bundle 'joonty/vdebug.git'
Bundle 'tpope/vim-fugitive'
Bundle 'shougo/vimproc'
Bundle 'khorser/vim-repl'

" Line numbers
set number

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

" tabwidth
set tabstop=4

" No eof newline
set noeol
set binary

" tabs = spaces
set expandtab
set shiftwidth=4
set softtabstop=4

" syntastic
"let g:syntastic_php_phpcs_args=['--report=csv']
"let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_checkers=['php']


" remap leader to ,
let mapleader = ","

" <leader>w to open and activate new split
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>l :!php -l "%"<CR>
nnoremap <leader>f yw :!grep 'function <C-r>"' * -r<CR>

nnoremap <C-j> :bprev<CR>
nnoremap <C-k> :bnext<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" yum
colorscheme desert

" format JSON
map <leader>j :%!python -m json.tool<CR>