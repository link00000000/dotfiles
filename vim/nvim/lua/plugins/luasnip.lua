---@type PluginModule
return {
    spec = {
        'L3MON4D3/LuaSnip',
        lazy = true,
        event = { "BufEnter" },
        config = function ()
            -- TODO: Look into history and if that is something I want
            require("luasnip").setup({
                update_events = "TextChanged,TextChangedI",
            })

            vim.api.nvim_create_user_command("LuasnipReload", "", { desc = "Reload LuaSnip snippets" })
        end,
    },
}
