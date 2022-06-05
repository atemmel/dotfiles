filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'dylanaraps/wal.vim'
Plugin 'neovim/nvim-lspconfig'
Plugin 'hrsh7th/nvim-cmp'
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'hrsh7th/cmp-buffer'
Plugin 'hrsh7th/cmp-cmdline'
Plugin 'hrsh7th/cmp-path'
Plugin 'L3MON4D3/LuaSnip'

call vundle#end()

colorscheme wal

set number
set scrolloff=7
set ts=4 sw=4
highlight Comment cterm=italic gui=italic

filetype plugin indent on

nnoremap Q <nop>
nnoremap <SPACE> <nop>

nnoremap j gj
nnoremap k gk
nnoremap J o
nnoremap K O
nnoremap q :q <CR>
nnoremap W :w <CR>
nnoremap E :find<SPACE>
nnoremap <C-e> :e<SPACE>
nnoremap e w
vnoremap e w
nnoremap w b
vnoremap w b
nnoremap U <C-r>
nnoremap <C-h> {
nnoremap <C-l> }

vmap <S-c> "+y

lua require'temmel'
