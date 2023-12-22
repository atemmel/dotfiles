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
nmap("<C-j>", ":lua vim.diagnostic.goto_next()<cr>")
nmap("<C-k>", ":lua vim.diagnostic.goto_prev()<cr>")

tmap("<C-w>", "<C-\\><C-n>")

vmap("<S-c>", "\"+y")
vmap("e", "w")
vmap("w", "b")

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
function OpenDiagnosticIfNoFloat()
	for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_win_get_config(winid).zindex then
			return
		end
	end

	vim.diagnostic.open_float({
		scope = "cursor",
		focusable = false,
		close_events = {
			"CursorMoved",
			"CursorMovedI",
			"BufHidden",
			"InsertCharPre",
			"WinLeave",
		},
	})
end

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	pattern = "*",
	command = "lua OpenDiagnosticIfNoFloat()",
	group = "lsp_diagnostics_hold",
})
