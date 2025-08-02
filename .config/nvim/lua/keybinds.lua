local dap, dapui = require("dap"), require("dapui")

require('telekasten').setup({
    home = vim.fn.expand("~/.zettelkasten"), -- Put the name of your notes directory here
})

local map = function(mode, keys, cmd)
    vim.api.nvim_set_keymap(
        mode,
        keys,
        cmd,
        {
            noremap = true,
            silent = true,
        }
    )
end

local imap = function(keys, cmd)
    map("i", keys, cmd)
end

local nmap = function(keys, cmd)
    map("n", keys, cmd)
end

local tmap = function(keys, cmd)
    map("t", keys, cmd)
end

local vmap = function(keys, cmd)
    map("v", keys, cmd)
end

nmap("<C-e>", ":e<SPACE>")
nmap("<C-h>", "{")
nmap("<C-l>", "}")
nmap("<C-r>", ":luafile ~/.config/nvim/init.lua<cr>")
nmap("<C-u>", ":syntax sync fromstart<cr>:setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2<cr>")
nmap("E", ":lua require'picker'.fd()<cr>")
nmap("J", "o")
nmap("K", "O")
nmap("M", ":make <bar>cw<cr>")
nmap("Q", "<nop>")
nmap("U", "<C-r>")
nmap("W", ":w<CR>")
nmap("cv", ":e ~/.config/nvim/<cr>")
nmap("e", "w")
nmap("fw", "<cmd>Telescope live_grep<cr>")
nmap("j", "gj")
nmap("k", "gk")
nmap("q", ":q <CR>")
nmap("ts", ":term spider<cr>")
nmap("tt", ":term<CR><CR>a<C-l>")
nmap("w", "b")
nmap("yh", ":!~/bin/here<cr><cr>")
nmap("<C-j>", ":lua vim.diagnostic.goto_next()<cr>")
nmap("<C-k>", ":lua vim.diagnostic.goto_prev()<cr>")

nmap("tp", ":lua require'picker'.projects('~/doc')<cr>")
nmap("tgc", ":lua require'picker'.checkout()<cr>")
nmap("gs", ":lua require'telescope.builtin'.lsp_document_symbols()<cr>")
-- TODO: this could be presented prettier
nmap("gp", ":!git pull<cr>")

tmap("<C-w>", "<C-\\><C-n>")

vmap("<S-c>", "\"+y")
vmap("e", "w")
vmap("w", "b")

-- Launch panel if nothing is typed after <leader>z
nmap(" z", "<cmd>Telekasten panel<CR>")

-- Most used functions
nmap(" zf", "<cmd>Telekasten find_notes<CR>")
nmap(" zg", "<cmd>Telekasten search_notes<CR>")
nmap(" zd", "<cmd>Telekasten goto_today<CR>")
nmap(" zz", "<cmd>Telekasten follow_link<CR>")
nmap(" zn", "<cmd>Telekasten new_note<CR>")
nmap(" zc", "<cmd>Telekasten show_calendar<CR>")
nmap(" zb", "<cmd>Telekasten show_backlinks<CR>")
nmap(" zI", "<cmd>Telekasten insert_img_link<CR>")

-- Call insert link automatically when we start typing a link
imap("[[", "<cmd>Telekasten insert_link<CR>")

local is_debug = false

function ToggleDebug()
    if is_debug then
        dapui.close()
        dap.disconnect()
    else
        dapui.open()
    end
    is_debug = not is_debug
end

nmap("dbg", ":lua require'keybinds'.ToggleDebug()<cr>")
nmap("<BS>", ":DapToggleBreakpoint<cr>")
nmap("gn", ":lua require'dap'.continue()<cr>")
nmap("gd", ":lua require'dap'.step_into()<cr>")
nmap("gu", ":lua require'dap'.step_out()<cr>")
nmap("go", ":lua require'dap'.step_over()<cr>")
nmap("gr", ":lua require'dap'.restart()<cr>")
nmap("gx", ":lua require'dap'.disconnect()<cr>")

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
function OpenDiagnosticIfNoFloat()
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
            return
        end
    end

    vim.diagnostic.open_float({
        scope = "cursor",
        focusable = false,
        close_events = {
            "CursorMoved",
            "CursorMovedI",
            "BufHidden",
            "InsertCharPre",
            "WinLeave",
        },
    })
end

-- Show diagnostics under the cursor when holding position
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    command = "lua OpenDiagnosticIfNoFloat()",
    group = "lsp_diagnostics_hold",
})

return {
    ToggleDebug = ToggleDebug,
}
