-- For debugging
-- vim.lsp.set_log_level("debug")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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
require'lspconfig'.sumneko_lua.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require'cmp'
local luasnip = require'luasnip'

--local telescope = require'telescope'
-- telescope.setup{
-- }

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
