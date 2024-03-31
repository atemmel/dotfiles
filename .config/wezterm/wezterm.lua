local wezterm = require 'wezterm'

local config = wezterm.config_builder()

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

return config
