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
    {
        "wnkz/monoglow.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    "L3MON4D3/LuaSnip",
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                "nvim-dap-ui",
            },
        },
    },
    "MunifTanjim/prettier.nvim",
    {
        'IogaMaster/neocord',
        event = "VeryLazy"
    },
    "dylanaraps/wal.vim",
    "folke/neodev.nvim",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "jose-elias-alvarez/null-ls.nvim",
    "leoluz/nvim-dap-go",
    "neovim/nvim-lspconfig",
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
    },
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
        'renerocksai/telekasten.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "c", "lua", "vim", "zig", "go", "java", "vimdoc", "query", },
            highlight = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        requires = {
            'nvim-treesitter/nvim-treesitter',
            'mfussenegger/nvim-dap',
        },
    },
    {
        "nvzone/typr",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats" },
    }
})

require "statusline"
require "general"
require "keybinds"

require "picker"

-- needs to be loaded before lsp
if vim.fn.executable("prettierd") == 1 then
    require "prettiercfg"
end

-- TODO
-- require "neodev".setup({})
require "lsp"
require "statusline"
require "autocmd"
require "diagrams"
require "home"
require "dbg"
Utils = require "utils"
Projects = require "projects"
