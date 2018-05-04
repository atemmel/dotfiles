set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'aurieh/discord.nvim'

Plugin 'xuhdev/vim-latex-live-preview'

Plugin 'scrooloose/nerdtree'

call vundle#end()

syntax on
filetype plugin indent on

set number
set scrolloff=7

autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'mupdf'

vmap <S-c> "*y
