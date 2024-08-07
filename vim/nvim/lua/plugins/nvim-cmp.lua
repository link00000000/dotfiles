---@type PluginModule
return {
    spec = {
        'hrsh7th/nvim-cmp',
        lazy = true,
        opts = function (_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, { name = "lazydev", group_index = 0 })
        end,
        config = function ()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

            -- Code editing
            ---@diagnostic disable-next-line
            cmp.setup({
                preselect = "None",
                snippet = {
                    expand = function (args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered({ border = "rounded", scrollbar = false, col_offset = -5 }),
                    documentation = cmp.config.window.bordered({ border = "rounded", scrollbar = false }),
                },
                ---@diagnostic disable-next-line
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function (entry, vim_item)
                        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        if #strings >= 2 then
                            kind.kind = " " .. strings[1] .. " "
                            kind.menu = "    (" .. strings[2] .. ")"
                        end

                        return kind
                    end,
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
                    { name = 'luasnip' },
                    { name = "nvim_lsp_signature_help" },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                }, {
                    { name = 'buffer' },
                    { name ="path" },
                }),
            })

            -- Text searching
            ---@diagnostic disable-next-line
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
                    completion = cmp.config.window.bordered({ border = "rounded", scrollbar = false }),
                    documentation = cmp.config.window.bordered({ border = "rounded", scrollbar = false }),
                },
            })

            -- Command execution
            ---@diagnostic disable-next-line
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
                        },
                    },
                },
                {
                    { name = 'cmdline' },
                }),
                window = {
                    completion = cmp.config.window.bordered({ border = "rounded", scrollbar = false }),
                    documentation = cmp.config.window.bordered({ border = "rounded", scrollbar = false }),
                },
            })
        end,
        dependencies = {
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "hrsh7th/cmp-path" },

            require("plugins.lspkind").spec,
        },
        event = { "BufEnter" },
    },
}
