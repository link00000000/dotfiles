-- local luasnip = require('luasnip')
local luasnip_loaders_from_vscode = require('luasnip.loaders.from_vscode')
local luasnip_loaders_from_lua = require('luasnip.loaders.from_lua')

local configDir = function ()
    return vim.cmd('echo stdpath(\'config\')')
end

luasnip_loaders_from_vscode.lazy_load()
luasnip_loaders_from_lua.load({ paths = "C:/Users/lcrandall/AppData/Local/nvim/snippets" })

-- local silent_opts = { silent = true }
-- local expr_opts = { silent = true, expr = true }
--
-- vim.api.nvim_set_keymap('i', '<Tab>', 'luasnip#expand_or_jumpable() ? \'<Plug>luasnip-expand-or-jump\' : \'<Tab>\'', expr_opts)
--
-- vim.keymap.set('i', '<S-Tab>',
--     function ()
--        luasnip.jump(-1)
--     end,
-- expr_opts)
--
-- vim.keymap.set('s', '<Tab>',
--     function ()
--         luasnip.jump(1)
--     end,
-- expr_opts)
--
-- vim.keymap.set('s', '<S-Tab>',
--     function ()
--         luasnip.jump(-1)
--     end,
-- expr_opts)

