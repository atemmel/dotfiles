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
	--"EdenEast/nightfox.nvim",
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
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	"nvim-treesitter/nvim-treesitter",
	"jbyuki/venn.nvim",
	{
		'nvim-java/nvim-java',
		dependencies = {
			'nvim-java/lua-async-await',
			'nvim-java/nvim-java-refactor',
			'nvim-java/nvim-java-core',
			'nvim-java/nvim-java-test',
			'nvim-java/nvim-java-dap',
			'MunifTanjim/nui.nvim',
			'neovim/nvim-lspconfig',
			'mfussenegger/nvim-dap',
			{
				'williamboman/mason.nvim',
				opts = {
					registries = {
						'github:nvim-java/mason-registry',
						'github:mason-org/mason-registry',
					},
				},
			}
		},
	},
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		config = function()
			require("neorg").setup {
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
							},
							default_workspace = "notes",
						},
					},
				},
			}
			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},
})

require "statusline"
require "general"
require "keybinds"

require "picker"

if os.execute("command -v prettierd") == 0 then
	require "prettiercfg"
end

-- TODO
-- require "neodev".setup({})
require "lsp"
require "statusline"
require "autocmd"
require "diagrams"
Utils = require "utils"
Projects = require "projects"
