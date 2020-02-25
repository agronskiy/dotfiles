set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

Plugin 'vim-scripts/indentpython.vim'

Bundle 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1

" Remapping the esc
inoremap jk <ESC>

" Remapping the leading key 
let mapleader = " "

" Show the entered command
set showcmd

" From https://danielmiessler.com/study/vim/
filetype plugin indent on
syntax on
set encoding=utf-8
set clipboard=unnamedplus

map ; :
noremap ;; ;

" Tabstop to 4
set ts=4 sw=4

