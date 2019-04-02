set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'aurieh/discord.nvim'
"Plugin 'ObserverOfTime/discord.nvim'

"Plugin 'scrooloose/nerdtree'

Plugin 'dylanaraps/wal.vim'

Plugin 'mattn/emmet-vim'

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
nnoremap <C-h> {
nnoremap <C-l> }
nnoremap U <C-r>

nnoremap M :make<bar>cw<cr>

vmap <S-c> "+y

"emmet nonsense
let g:user_emmet_mode='n'    "only enable normal mode functions.
"let g:user_emmet_mode='inv'  "enable all functions, which is equal to
"let g:user_emmet_mode='a'    "enable all function in all mode.

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

set ruler
