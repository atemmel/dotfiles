local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_domain = 'WSL:Arch'

config.enable_tab_bar = false

--TODO: byt till vadhelst neovide har
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font(
			"JetBrains Mono",
			{
				weight = "Bold",
				stretch = "Normal",
				style = "Normal",
			}
		),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font(
			"JetBrains Mono",
			{
				weight = "Bold",
				stretch = "Normal",
				style = "Italic"
			}
		),
	},
}
config.font_size = 11
config.window_padding = {
	left = "8pt",
	right = "8pt",
	top = "4pt",
	bottom = 0,
}

config.colors = {
	cursor_bg = 'white',
	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = 'black',
	-- Overrides the text color when the current cell is not occupied by the cursor
	cursor_border = 'white',
}

return config
