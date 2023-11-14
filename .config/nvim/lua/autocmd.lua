local au = vim.api.nvim_create_autocmd;

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
			"*.js",
			"*.ts",
			"*.vue",
			"*.html",
			"*.json",
		},
		command = "setlocal expandtab tabstop=2, shiftwidth=2, softtabstop=2",
	}
)

au(
	"BufWritePre",
	{
		pattern = "*",
		command = "lua vim.lsp.buf.format()",
	}
)
