autocmd!
scriptencoding utf-8
if !1 | finish | endif

set nocompatible
set number
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
"set clipboard=unnamed
set scrolloff=10
set expandtab
set mouse=a
"let loaded_matchparen = 1
set shell=bash
set backupskip=/tmp/*,/private/tmp/*
set undodir=~/.vimdid
set undofile

if has('nvim')
  set inccommand=split
endif

set t_BE=

set nosc noru nosm
set lazyredraw
set ignorecase
set smarttab
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set wrap
set backspace=start,eol,indent
set path+=**
set wildignore+=*/node_modules/*

autocmd InsertLeave * set nopaste

set formatoptions+=r
set cursorline


au BufNewFile,BufRead *.es6 setf javascript
au BufNewFile,BufRead *.tsx setf typescriptreact
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.js set filetype=javascript
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
set exrc
let g:terraform_fmt_on_save=1
let g:terraform_align=1

" Load the colorscheme
set termguicolors
let g:monokaipro_filter = "spectrum"
let g:monokaipro_italic_functions = 1
let g:monokaipro_flat_term = 1
"colorscheme monokaipro
set background=light
colorscheme zenbones
