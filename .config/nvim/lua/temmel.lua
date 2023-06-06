-- For debugging
-- vim.lsp.set_log_level("debug")

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
	vim.keymap.set("n", "H", vim.lsp.buf.hover, {buffer=0})
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
	vim.keymap.set("n", "cn", vim.lsp.buf.rename, {buffer=0})
end

require'lspconfig'.zls.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}
require'lspconfig'.gopls.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}
require'lspconfig'.clangd.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}
require'lspconfig'.lua_ls.setup{
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	},
}
require'lspconfig'.jdtls.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}
require'lspconfig'.volar.setup{
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {
		'typescript',
		'javascript',
		'javascript-react',
		'typescript-react',
		'vue',
		'json',
	},
	init_options = {
		typescript = {
			serverpath = '/usr/lib/node_modules/typescript/lib/tsserverlibrary.js',
		},
	},
}

-- The setup config table shows all available config options with their default values:
require("presence"):setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    -- client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
	log_lvel            = nil,
    --log_level           = "debug",                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require'cmp'
local luasnip = require'luasnip'

local ignore = {
	"%.ico",
	"%.idea",
	"%.jar",
	"%.properties",
	".vscode",
	"package-lock.json",
	"package.json",
	"target/",
    "%.class",
    "%.exe",
    "%.git/",
    "%.jpg",
    "%.mp3",
    "%.o",
    "%.png",
    "%.ttf",
    "%.zip",
    "build/",
    "go.sum",
    "node_modules",
    "zig-cache",
    "zig-out",
}

local telescope = require'telescope'
telescope.setup{
     defaults = {
         file_ignore_patterns = ignore,
     }
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
    sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
	})
})
