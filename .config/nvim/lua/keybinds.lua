local map = function(mode, keys, cmd)
	vim.api.nvim_set_keymap(
		mode,
		keys,
		cmd,
		{
			noremap = true,
			silent = true,
		}
	)
end

local nmap = function(keys, cmd)
	map("n", keys, cmd)
end

local tmap = function(keys, cmd)
	map("t", keys, cmd)
end

local vmap = function(keys, cmd)
	map("v", keys, cmd)
end

nmap("<C-e>", ":e<SPACE>")
nmap("<C-h>", "{")
nmap("<C-l>", "}")
nmap("<C-r>", ":source ~/.config/nvim/init.vim<cr>")
nmap("<C-u>", ":syntax sync fromstart<cr>:setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2<cr>")
nmap("E", ":lua require'picker'.fd()<cr>")
nmap("J", "o")
nmap("K", "O")
nmap("M", ":make <bar>cw<cr>")
nmap("Q", "<nop>")
nmap("U", "<C-r>")
nmap("W", ":w<CR>")
nmap("cv", ":e ~/.config/nvim/<cr>")
nmap("e", "w")
nmap("fw", "<cmd>Telescope live_grep<cr>")
nmap("j", "gj")
nmap("k", "gk")
nmap("q", ":q <CR>")
nmap("ts", ":term spider<cr>")
nmap("tt", ":term<CR><CR>a<C-l>")
nmap("w", "b")
nmap("yh", ":!~/bin/here<cr><cr>")

tmap("<C-w>", "<C-\\><C-n>")

vmap("<S-c>", "\"+y")
vmap("e", "w")
vmap("w", "b")
