local center_list = require"telescope.themes".get_dropdown({
	previewer = false,
	results_height = 28,
	layout_config = {
		height = 0.7,
		width = 0.8,
	},
})

local picker = {}

picker.fd = function () 
	local opts = center_list
	require"telescope.builtin".fd(opts)
end

return picker
