local au = vim.api.nvim_create_autocmd;

-- TODO: this should be a set
local prettier_files = {
	"css",
	"html",
	"javascript",
	"json",
	"scss",
	"typescript",
	"vue",
}

local prettier = require "prettier"

function maybe_format()
	for _, value in pairs(prettier_files) do
		if value == vim.bo.filetype then
			prettier.format()
			return
		end
	end
	vim.lsp.buf.format()
end

au(
	"Filetype",
	{
		pattern = "*.cpp",
		command = "setlocal makeprg=cmake --build build",
	}
)

if vim.fn.exists("current_compiler") ~= 0 then
	vim.api.nvim_command("set makeprg=make -C build")
end

au(
	"Filetype",
	{
		pattern = {
			"*.css",
			"*.html",
			"*.js",
			"*.json",
			"*.scss",
			"*.ts",
			"*.vue",
		},
		command = "setlocal expandtab tabstop=2, shiftwidth=2, softtabstop=2",
	}
)

au(
	"BufWritePre",
	{
		pattern = "*",
		command = "lua maybe_format()",
	}
)
