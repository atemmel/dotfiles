local api = vim.api

local ctx = {}

local _ = {
    "    _/    _/                                  ",
    "   _/    _/    _/_/    _/_/_/  _/_/      _/_/ ",
    "  _/_/_/_/  _/    _/  _/    _/    _/  _/_/_/_/",
    " _/    _/  _/    _/  _/    _/    _/  _/       ",
    "_/    _/    _/_/    _/    _/    _/    _/_/_/  ",
}

local logo = {
    " ▄  █ ████▄ █▀▄▀█ ▄███▄  ",
    "█   █ █   █ █ █ █ █▀   ▀ ",
    "██▀▀█ █   █ █ ▄ █ ██▄▄   ",
    "█   █ ▀████ █   █ █▄   ▄▀",
    "   █           █  ▀███▀  ",
    "  ▀           ▀          ",
}

-- draw the graphics into the screen center
local function center_align(tbl)
    vim.validate({
        tbl = { tbl, 'table' },
    })
    local function fill_sizes(lines)
        local fills = {}
        for _, line in pairs(lines) do
            table.insert(fills, math.floor((vim.o.columns - api.nvim_strwidth(line)) / 2))
        end
        return fills
    end

    local centered_lines = {}
    local fills = fill_sizes(tbl)

    for i = 1, #tbl do
        local fill_line = (' '):rep(fills[i]) .. tbl[i]
        table.insert(centered_lines, fill_line)
    end

    return centered_lines
end

local function setup()
    local opts = {
        ['bufhidden'] = 'wipe',
        ['buftype'] = 'nofile',
        ['colorcolumn'] = '',
        ['foldcolumn'] = '0',
        ['matchpairs'] = '',
        ['buflisted'] = false,
        ['cursorcolumn'] = false,
        ['cursorline'] = false,
        ['list'] = false,
        ['number'] = false,
        ['relativenumber'] = false,
        ['spell'] = false,
        ['swapfile'] = false,
        ['readonly'] = false,
        ['wrap'] = false,
        ['signcolumn'] = 'no',
    }
    for opt, val in pairs(opts) do
        vim.opt_local[opt] = val
    end

    local h = api.nvim_win_get_height(ctx.winid)
    local y = math.floor(h / 2 - #logo / 2)
    local logo_table = {}

    for _ = 0, y, 1 do
        table.insert(logo_table, "")
    end

    for _, line in pairs(logo) do
        table.insert(logo_table, line)
    end

    for _ = 0, y, 1 do
        table.insert(logo_table, "")
    end

    api.nvim_buf_set_lines(ctx.bufnr, 0, -1, false, center_align(logo_table))

    vim.bo[ctx.bufnr].modifiable = false
end

api.nvim_create_autocmd('UIEnter', {
    callback = function()
        if
            vim.fn.argc() == 0
            and api.nvim_buf_get_name(0) == ''
            and vim.g.read_from_stdin == nil
        then
            ctx.bufnr = api.nvim_create_buf(false, true)
            ctx.winid = api.nvim_get_current_win()
            api.nvim_win_set_buf(ctx.winid, ctx.bufnr)
            setup()
        end
    end,
})
