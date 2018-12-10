set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'aurieh/discord.nvim'
"Plugin 'ObserverOfTime/discord.nvim'

"Plugin 'scrooloose/nerdtree'

Plugin 'dylanaraps/wal.vim'

call vundle#end()

syntax on

colorscheme wal

filetype plugin indent on

set number
set scrolloff=7
set ts=4 sw=4
"set cc=80

"autocmd Filetype tex setl updatetime=1

inoremap ii <ESC>
nnoremap H K
nnoremap J o
nnoremap K O
nnoremap o :
nnoremap O ZZ
nnoremap q :q <CR>
nnoremap W :w <CR>
nnoremap E :e<SPACE>
nnoremap : <Nop>
nnoremap Q <nop>
nnoremap e w
nnoremap w b
nnoremap 7 I//<ESC>
vmap <S-c> "+y

set ruler
