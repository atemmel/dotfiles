local rocks_config = {
	rocks_path = "/home/temmel/.local/share/nvim/rocks",
	luarocks_binary = "/home/temmel/.local/share/nvim/rocks/bin/luarocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
	vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
	vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
	vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
	vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "*", "*"))

--[[
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
	"EdenEast/nightfox.nvim",
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
--]]

require "statusline"
require "general"
require "keybinds"

require "picker"

if os.execute("command -v prettierd") == 0 then
	require "prettiercfg"
end

require "neodev".setup({})
require "lsp"
require "statusline"
require "autocmd"
require "diagrams"
Utils = require "utils"
Projects = require "projects"
