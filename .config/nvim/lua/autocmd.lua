local utils = require "utils"

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

local prettier_files = {
	"css",
	"html",
	"javascript",
	"json",
	"scss",
	"typescript",
	"vue",
}

local prettier = require("prettier")

local function format_xml()
	local contents = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local cmd = string.format("echo '%s' | xmllint --format -", table.concat(contents, "\n"))
	local file = io.popen(cmd, "r")
	if file == nil then
		return
	end
	local output = file:read("*a")
	local list = utils.split(output, "\n")
	vim.api.nvim_buf_set_lines(0, 0, -1, false, list)
end

function Format()
	for _, value in pairs(prettier_files) do
		if value == vim.bo.filetype then
			prettier.format()
			return
		end
	end
	if vim.bo.filetype == "xml" then
		format_xml()
	else
		vim.lsp.buf.format()
	end
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
		command = "lua Format()",
	}
)
