vim.api.nvim_exec2([[
set number
set scrolloff=7
set ts=4 sw=4
set expandtab
highlight Comment cterm=italic gui=italic
filetype plugin indent on
set updatetime=1000
set updatetime=500

colorscheme wal
"colorscheme carbonfox

if exists('g:neovide')
	let g:neovide_remember_window_size = v:true
	let g:neovide_input_use_logo = v:true
	let g:neovide_cursor_vfx_mode = "wireframe"
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
endif

]], {})
