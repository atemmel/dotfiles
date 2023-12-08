local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

Statusline = {}

Statusline.active = function()
	return table.concat {
		"%#Statusline#",
		mode(),
		"%#Normal# ",
		filepath(),
		filename(),
		"%=%#StatusLineExtra#",
		filetype(),
		lineinfo(),
	}
end

Statusline.inactive = function()
	return " %F"
end

vim.api.nvim_exec2([[
	augroup Statusline
		au!
		au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
		au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
	augroup END
]], {})

vim.cmd "set noshowmode"
vim.cmd "set noshowcmd"

vim.cmd "set fillchars=vert:\\ "
vim.cmd "hi! VertSplit guifg=black guibg=black ctermfg=black ctermbg=black"
