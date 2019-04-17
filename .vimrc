set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'aurieh/discord.nvim'

Plugin 'dylanaraps/wal.vim'

call vundle#end()

syntax on

colorscheme wal

filetype plugin indent on

set number
set scrolloff=7
set ts=4 sw=4
"set cc=80

inoremap ii <ESC>

nnoremap : <nop>
nnoremap Q <nop>
nnoremap <SPACE> <nop>

nnoremap H K
nnoremap J o
nnoremap K O
nnoremap o :
nnoremap O ZZ
nnoremap q :q <CR>
nnoremap W :w <CR>
nnoremap E :e<SPACE>
nnoremap e w
nnoremap w b
nnoremap 3 I#<ESC>
nnoremap 7 I//<ESC>
nnoremap U <C-r>

nnoremap <C-h> {
nnoremap <C-l> }

nnoremap M :make<bar>cw<cr>

vmap <S-c> "+y

set ruler
