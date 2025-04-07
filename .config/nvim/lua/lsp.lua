-- For debugging
-- vim.lsp.set_log_level("debug")

local home = os.getenv("HOME")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
    vim.keymap.set("n", "H", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "cn", vim.lsp.buf.rename, { buffer = 0 })
end

require "lspconfig".zls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require "lspconfig".gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require "lspconfig".clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
require "lspconfig".lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
            },
        },
    },
}
require "lspconfig".pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require "java".setup({})

require "lspconfig".jdtls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "Java 21",
                        path = "/lib/jvm/java-21-openjdk",
                        default = true,
                    },
                    {
                        name = "Java 11",
                        path = "/lib/jvm/java-11-openjdk",
                    },
                    {
                        name = "Java 8",
                        path = "/lib/jvm/java-8-openjdk",
                    },
                },
            },

        },

    },
}

require "lspconfig".volar.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
        "javascript",
        "javascript-react",
        "json",
        "typescript",
        "typescript-react",
        "vue",
    },
    init_options = {
        typescript = {
            tsdk = "/usr/lib/node_modules/typescript/lib",
        },
        vue = {
            hybridMode = false,
        },
    },
}

if vim.fn.executable("superhtml") == 1 then
    require 'lspconfig'.superhtml.setup {}
end

local signs = {
    Error = "\u{ea87}",
    Warn  = "\u{e654}",
    Hint  = "\u{f420}",
    Info  = "\u{f449}",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function setup_lsp_diags()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            signs = true,
            update_in_insert = false,
            underline = true,
        }
    )
end

setup_lsp_diags()

-- The setup config table shows all available config options with their default values:
require("neocord").setup({
    -- General options
    logo                = "auto",                -- "auto" or url
    logo_tooltip        = nil,                   -- nil or string
    main_image          = "language",            -- "language" or "logo"
    client_id           = "1157438221865717891", -- Use your own Discord application client id (not recommended)
    log_level           = nil,                   -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                    -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    blacklist           = {},                    -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    file_assets         = {},                    -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                  -- Show the timer
    global_timer        = false,                 -- if set true, timer won't update when any event are triggered

    -- Rich Presence text options
    editing_text        = "Editing %s",         -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",        -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",   -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",         -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",      -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",  -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    terminal_text       = "Using Terminal",     -- Format string rendered when in terminal mode.
})

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s", "c" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
        { name = "path" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
    })
})
