" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

filetype off

call plug#begin('~/.vim/plugged')

" LSP
"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
" coc
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }

"lang specific
" Go
Plug 'fatih/vim-go'
" Clojure
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
" Plug 'vim-scripts/paredit.vim'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" needs lein-cljfmt on classpath
Plug 'venantius/vim-cljfmt' 
Plug 'kien/rainbow_parentheses.vim'
" Markdown
Plug 'kannokanno/previm'
" scala
" Plug 'derekwyatt/vim-scala'
" typescript
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'ryanolsonx/vim-lsp-typescript'

" Style
Plug 'altercation/vim-colors-solarized'

" Completion
" Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'zchee/deoplete-go'
" Plug 'shougo/vimproc'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
" File mgmt
" Plug 'wincent/command-t'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Debug
" Plug 'joonty/vdebug.git'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" I dunno
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

call plug#end()

let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeGlyphReadOnly = 'RO'
let g:NERDTreeNodeDelimiter = "\u00a0"

" LSP
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" END LSP

" COC
" If hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" You will have a bad experience with diagnostic messages with the default 4000.
set updatetime=300

" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

" Help Vim recognize *.sbt and *.sc as Scala files
au BufRead,BufNewFile *.sbt,*.sc set filetype=scala

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
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

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Trigger for code actions
" Make sure `"codeLens.enable": true` is set in your coc config
nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
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

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>
" END COC


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
let g:ctrlp_custom_ignore = 'DS_Store\|\.git\|target'
nnoremap <leader>t :CtrlP .<CR>
let g:ctrlp_working_path_mode = 'ra'

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

" from pc
" let g:gitgutter_realtime = 0
" let g:gitgutter_eager = 0

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

hi clear SignColumn

" FileType specifics
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2
autocmd FileType terraform setlocal shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType json setlocal shiftwidth=2 softtabstop=2
autocmd FileType json syntax match Comment +\/\/.\+$+

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
au FileType json setlocal foldmethod=syntax

" super (as ctrl via autokey)
nmap  :w<cr>
imap  <ESC>l:w<cr>i
nmap  :!gvim<cr><cr>

" alt
nmap ó :w<cr>
imap ó <ESC>l:w<cr>i
nmap ÷ :clo<cr>
nmap á ggVG<cr>
map ã "+y
map ö "+P
map  "+y
map  "+d
map  "+P
nmap  "+y
nmap  "+d
nmap  "+P
imap  <ESC>"+y
imap  <ESC>"+d
imap  <ESC>"+P
vmap  "+y
vmap  "+d
vmap  "+P
imap ã <ESC>"+yi
imap ö <ESC>"+Pi
vmap ö "+Pv

" LCAG
map  :w<cr>
map  ggVG
vmap  <ESC>:w<cr>
vmap  <ESC>ggVG
imap  <ESC>:w<cr>i
imap  <ESC>ggVGi
nmap  :w<cr>
nmap  ggVG
nmap  :!gvim<cr><cr>

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
let g:go_debug_windows = {
    \ 'stack': 'botright 10new',
    \ 'vars': 'topleft 20vnew',
\ }
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
let g:previm_open_cmd = 'default'
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

set guioptions-=m

"
" Markdown specific stuff.
"
" Change default app for Vim-marked. I have Marked2, but it is just called "Marked". Maybe because it is the non-AS version?
"let g:marked_app = "Marked"
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd Filetype markdown Goyo