vim.api.nvim_exec2([[
set number
set scrolloff=7
set ts=4 sw=4
highlight Comment cterm=italic gui=italic
filetype plugin indent on
]], {})
