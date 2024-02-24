local M = {}

local function config ()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    ---@diagnostic disable-next-line
    cmp.setup({
        snippet = {
            expand = function (args)
                luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function (entry, vim_item)
                local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                if table.getn(strings) >= 2 then
                    kind.kind = " " .. strings[1] .. " "
                    kind.menu = "    (" .. strings[2] .. ")"
                end

                return kind
            end,
        },
        completion = {
            -- completeopt = 'menu,menuone,noinsert,noselect',
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-S-k>'] = cmp.mapping.scroll_docs(-4),
            ['<PageUp>'] = cmp.mapping.scroll_docs(-4),
            ['<C-S-j>'] = cmp.mapping.scroll_docs(4),
            ['<PageDown>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-j>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-k>'] = cmp.mapping(function (fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
        }, {
            { name = 'buffer' },
            { name ="path" }
        }),
    })

    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline({
            ['<C-S-k>'] = cmp.mapping.scroll_docs(-4),
            ['<C-S-j>'] = cmp.mapping.scroll_docs(4),
            ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        }),
        sources = cmp.config.sources({
            { name = 'buffer' },
        }),
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
        },
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
            ['<C-S-k>'] = cmp.mapping.scroll_docs(-4),
            ['<C-S-j>'] = cmp.mapping.scroll_docs(4),
            ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        }),
        sources = cmp.config.sources({},
        {
            {
                name = 'path',
                option = {
                    trailing_slash = false,
                    label_trailing_slash = true,
                }
            },
        },
        {
            { name = 'cmdline' },
        }),
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
        },
    })
end

M.spec = {
    'hrsh7th/nvim-cmp',
    lazy = true,
    config = config,
    dependencies = {
        require("plugins.cmp-nvim-lsp").spec,
        require("plugins.cmp-buffer").spec,
        require("plugins.cmp-path").spec,
        require("plugins.cmp-cmdline").spec,
        require("plugins.cmp-nvim-lua").spec,

        require("plugins.luasnip").spec,
        require("plugins.lspkind").spec,
    },
    event = { "BufEnter" }
}

return M
