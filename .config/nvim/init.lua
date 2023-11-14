require "general"
require "keybinds"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	print("Installing Lazy...")
	print(vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}))
end

vim.opt.rtp:prepend(lazypath)

require "lazy".setup({
	"L3MON4D3/LuaSnip",
	"MunifTanjim/prettier.nvim",
	"VundleVim/Vundle.vim",
	"andweeb/presence.nvim",
	"dylanaraps/wal.vim",
	"folke/neodev.nvim",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",
	"jose-elias-alvarez/null-ls.nvim",
	"neovim/nvim-lspconfig",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-treesitter/nvim-treesitter",
})

require "picker"

if os.execute("command -v prettierd") == 0 then
	require "prettiercfg"
end
require "temmel"
