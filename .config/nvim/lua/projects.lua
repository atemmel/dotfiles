local utils = require "utils"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config".values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"


---Finds git projects
---@param dir string
---@return table
local function find(dir)
	local cmd = "find " .. dir .. " -name node_modules -prune -o -name .git -print | sort"
	local file = io.popen(cmd, "r")
	if file == nil then
		return {}
	end
	local output = file:read("*a")
	local list = utils.split(output, "\n")
	for k, v in pairs(list) do
		list[k] = string.sub(v, 1, -6)
	end
	return list
end

---Opens a picker to select git projects
---@param dir string
---@param opts object
local function picker(dir, opts)
	opts = opts or {}

	local projects = find(dir)

	pickers.new(opts, {
		prompt_title = "projects",
		finder = finders.new_table {
			results = projects,
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, _)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				vim.api.nvim_set_current_dir(selection[1])
			end)
			return true
		end,

	}):find()
end

return {
	find = find,
	picker = picker,
}
