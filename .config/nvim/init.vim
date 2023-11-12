filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()

Plugin 'L3MON4D3/LuaSnip'
Plugin 'MunifTanjim/prettier.nvim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'andweeb/presence.nvim'
Plugin 'dylanaraps/wal.vim'
Plugin 'folke/neodev.nvim'
Plugin 'hrsh7th/cmp-buffer'
Plugin 'hrsh7th/cmp-cmdline'
Plugin 'hrsh7th/cmp-nvim-lsp'
Plugin 'hrsh7th/cmp-path'
Plugin 'hrsh7th/nvim-cmp'
Plugin 'jose-elias-alvarez/null-ls.nvim'
Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim'
Plugin 'nvim-treesitter/nvim-treesitter'

call vundle#end()

set number
set scrolloff=7
set ts=4 sw=4
highlight Comment cterm=italic gui=italic

filetype plugin indent on

if exists('g:neovide')
	colorscheme atom
	let g:neovide_remember_window_size = v:true
	let g:neovide_input_use_logo = v:true
	let g:neovide_cursor_vfx_mode = "wireframe"
	let g:terminal_color_0 = '#304050'
	let g:terminal_color_1 = '#e8ecf0'
	let g:terminal_color_3 = '#FFFF80'
	nnoremap tT :!cmd.exe /C start wt.exe -d $(pwd)<cr><cr>
	au FileType netrw nmap <buffer> tT :!cmd.exe /C start wt.exe -d $(pwd)<cr><cr>

	let g:neovide_scale_factor=1.0
	function! ChangeScaleFactor(delta)
		let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
	endfunction

	function! ResetScaleFactor()
		let g:neovide_scale_factor = 1.0
	endfunction

	nnoremap <expr>s+ ChangeScaleFactor(1.1)
	nnoremap <expr>s- ChangeScaleFactor(1/1.1)
	nnoremap <expr>s= ResetScaleFactor()
else
	colorscheme wal
endif

autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype vue setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

autocmd BufWritePre * lua vim.lsp.buf.format()

nnoremap Q <nop>

nnoremap j gj
nnoremap k gk
nnoremap J o
nnoremap K O
nnoremap q :q <CR>
nnoremap W :w <CR>
nnoremap E :lua require'picker'.fd()<cr>
nnoremap fw <cmd>Telescope live_grep<cr>
nnoremap yh :!~/bin/here<cr><cr>
vnoremap yh :!~/bin/here<cr><cr>
nnoremap tt :term<CR><CR>a<C-l>
au FileType netrw nmap <buffer> tt :term<CR><CR>a<C-l>
"nnoremap ts :term<CR><CR>A<C-l><C-u><cr>spider<cr>
nnoremap ts :term spider<cr>
tnoremap <C-w> <C-\><C-n>
nnoremap <C-e> :e<SPACE>
nnoremap e w
vnoremap e w
nnoremap w b
vnoremap w b
nnoremap U <C-r>
nnoremap <C-h> {
nnoremap <C-l> }
nnoremap <C-r> :source ~/.config/nvim/init.vim<cr>
nnoremap <C-u> :syntax sync fromstart<cr>:setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2<cr>
nnoremap cv :e ~/.config/nvim/<cr>

vmap <S-c> "+y

autocmd Filetype cpp setlocal makeprg=cmake\ --build\ build

if !exists("current_compiler")
	set makeprg=make\ -C\ build
end
nnoremap M :make <bar>cw<cr>

"set foldmethod=indent
set foldmethod=marker fmr=//<,//>

nnoremap <space> zA
nnoremap zr zR
nnoremap zm zM

fun! Logo()
	let splash = readfile($HOME ."/bin/gengar")
	let y = (winheight(0) - len(splash)) / 2
	let x = (winwidth(0) - len(splash[0])) / 2

	let i = 0
	let pad = ''
	while i < x
		let pad .= ' '
		let i += 1
	endwhile

	let i = 0
	while i < winheight(0)
		call append('$', ' ')
		let i += 1
	endwhile

	let i = 0
	for line in splash	
		call setline(y + i, pad . line)
		let i += 1
	endfor
endfun

fun! Start()

	"Create a new unnamed buffer to display our splash screen inside of.
	enew

	" Set some options for this buffer to make sure that does not act like a
	" normal winodw.
	file Home
	setlocal
		\ bufhidden=wipe
		\ buftype=nofile
		\ nobuflisted
		\ nocursorcolumn
		\ nocursorline
		\ nolist
		\ nonumber
		\ noswapfile
		\ norelativenumber

	call Logo()

	"call setline('$', splash)	
	" When we are done writing out message set the buffer to readonly.
	setlocal
	\ nomodifiable
	\ nomodified
endfun

" http://learnvimscriptthehardway.stevelosh.com/chapters/12.html
" Autocommands are a way of setting handlers for certain events.
" `VimEnter` is the event we want to handle. http://vimdoc.sourceforge.net/htmldoc/autocmd.html#VimEnter
" The cleene star (`*`) is a pattern to indicate which filenames this Autocommand will apply too. In this case, star means all files.
" We will call the `Start` function to handle this event.

" http://vimdoc.sourceforge.net/htmldoc/eval.html#argc%28%29
" The number of files in the argument list of the current window.
" If there are 0 then that means this is a new session and we want to display
" our custom splash screen.
if argc() == 0
	autocmd VimEnter * call Start()
endif

lua require'temmel'
lua require'prettiercfg'
