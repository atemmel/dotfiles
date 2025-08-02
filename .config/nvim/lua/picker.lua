Picker = {}

local ignore = {
    "%.asset",
    "%.class",
    "%.exe",
    "%.git",
    "%.git/",
    "%.ico",
    "%.idea",
    "%.jar",
    "%.jpg",
    "%.jpg",
    "%.meta",
    "%.mp3",
    "%.o",
    "%.png",
    "%.ttf",
    "%.unity",
    "%.vscode",
    "%.woff2",
    "%.zip",
    ".vscode",
    "build/",
    "go.sum",
    "node_modules",
    "node_modules/",
    "target/",
    "vendor/",
    "zig-cache",
    "zig-cache/",
    "zig-out",
    "zig-out/",
}

require "telescope".setup({
    defaults = {
        file_ignore_patterns = ignore,
    }
})

local center_list = require "telescope.themes".get_dropdown({
    previewer = false,
    results_height = 28,
    layout_config = {
        height = 0.7,
        width = 0.8,
    },
})

Picker.fd = function()
    local opts = center_list
    require "telescope.builtin".fd(opts)
end

---Opens a styled picker to select git projects
---@param dir string
---@return table
Picker.projects = function(dir)
    local opts = center_list
    require "projects".picker(dir, opts)
end

Picker.checkout = function()
    local opts = center_list
    require "telescope.builtin".git_branches(opts)
end

return Picker
