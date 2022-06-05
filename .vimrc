set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
set path=.,,**
set wildignore+=.git,.git/*,*.o,**/node_modules/**,*/build/*,*.png,*.jpg,go.sum,*.mp3,*.ttf,*.zip,*.exe,**/output/**,*.class,*.aux,*.bbl,*.bcf,*.log,*.out,*.pdf,bin/**,**/zig-out/**,**/zig-cache/**
set nrformats+=alpha

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'dylanaraps/wal.vim'

Plugin 'neoclide/coc.nvim'

"Plugin 'aurieh/discord.nvim'

Plugin 'salsifis/vim-transpose'

call vundle#end()

syntax on

colorscheme wal
highlight Comment cterm=italic gui=italic

filetype plugin indent on

set number
set scrolloff=7
set ts=4 sw=4
"set cc=80

"COC
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Navigate with tab and s-tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <silent> gd <Plug>(coc-definition)
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap cn <Plug>(coc-rename)
"COC

nnoremap Q <nop>
nnoremap <SPACE> <nop>

nnoremap j gj
nnoremap k gk
nnoremap H K
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
nnoremap 3 I#<ESC>
"nnoremap 7 I//<ESC>
nnoremap 7 :call Comment()<CR>
nnoremap 2 I"<ESC>
nnoremap U <C-r>

nnoremap <C-h> {
nnoremap <C-l> }

inoremap <C-o> )

autocmd Filetype gh setlocal makeprg=ghoul\ build\ %
"nnoremap M :make -C build<bar>cw<cr>
if !exists("current_compiler")
	set makeprg=make\ -C\ build
end

nnoremap M :make <bar>cw<cr>


vmap <S-c> "+y

set ruler

fun! Logo()
	" Our message goes here. Mine is simple.
	let splash = readfile($HOME ."/.bin/gengar")
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

fun! Comment()
	let prefix = strpart(trim(getline('.')), 0, 2)
	if prefix ==# "//"
		call UndoComment()
	else
		call DoComment()
	endif
endfun

fun! DoComment()
	execute ":silent! normal ^i//\<ESC>==\^"
endfun

fun! UndoComment()
    execute ":silent! normal :nohlsearch\<CR>:s/\\/\\///\<CR>:nohlsearch\<CR>=="
endfun

"Hmm...
"au BufRead,BufNewFile *.scp set filetype=scp
