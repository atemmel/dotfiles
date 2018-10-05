set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'aurieh/discord.nvim'

Plugin 'xuhdev/vim-latex-live-preview'

Plugin 'scrooloose/nerdtree'

Plugin 'dylanaraps/wal.vim'

call vundle#end()

syntax on

colorscheme wal

filetype plugin indent on

set number
set scrolloff=7
set ts=4 sw=4
""set cc=80

autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'mupdf'

vmap <S-c> "+y

set ruler
