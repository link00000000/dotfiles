local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
        config = function ()
            require("multicursors").setup({
                normal_keys = {
                    ["<C-d>"] = {
                        method = function ()
                            require("multicursors.normal_mode").find_next()
                        end,
                        opts = { desc = "Find next" },
                    }
                }
            })

            vim.api.nvim_set_hl(0, "MultiCursorMain", { link = "Search" })
            vim.api.nvim_set_hl(0, "MultiCursor", { link = "MultiCursorMain" })
        end,
        keys = {
            keymap.visual.lazy("<C-d>", function ()
                require("multicursors").search_visual()
                require("multicursors.normal_mode").find_next()
            end, { desc = "Start multi-cursor selection for current selection" }),
        },
        cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
        dependencies = {
            require("plugins.hydra").spec,
        }
    },
}
