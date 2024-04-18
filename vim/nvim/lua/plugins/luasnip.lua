local setup_snippets = function ()
    -- Load filetype snippets
    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snippets/ft/*.lua", true)) do
        loadfile(ft_path)()
    end
end

---@type PluginModule
return {
    spec = {
        'L3MON4D3/LuaSnip',
        config = function ()
            local ls = require("luasnip")
            local amend_keymap = require("keymap-amend")

            amend_keymap({ "i", "s" }, "<Tab>", function (original)
                if ls.in_snippet() then
                    ls.jump(1)
                else
                    original()
                end
            end, { desc = "Jump to next LuaSnip input" })

            amend_keymap({ "i", "s" }, "<S-Tab>", function (original)
                if ls.in_snippet() then
                    ls.jump(-1)
                else
                    original()
                end
            end, { desc = "Jump to previous LuaSnip input" })

            amend_keymap({ "i", "s" }, "<Esc>", function (original)
                if ls.in_snippet() then
                    ls.unlink_current()
                end

                original()
            end, { desc = "Exits out of the current LuaSnip context" })

            -- TODO: Look into history and if that is something I want
            ls.setup({
                update_events = "TextChanged,TextChangedI",
            })

            -- TODO: Replace with LuaSnip auto reloading
            vim.api.nvim_create_user_command("LuaSnipReload", setup_snippets, { desc = "Reload LuaSnip snippets" })
            setup_snippets()
        end,
        dependencies = {
            require("plugins.keymap-amend").spec,
        },
    },
}
