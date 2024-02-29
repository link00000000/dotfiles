local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "kevinhwang91/nvim-hlslens",
        config = function ()
            require("hlslens").setup({
                auto_enable = true,
                calm_down = true,
                nearest_only = true,
            })

            vim.api.nvim_set_hl(0, "HlSearchNear", { link = "Search" })
            vim.api.nvim_set_hl(0, "HlSearchLens", { link = "Search" })
            vim.api.nvim_set_hl(0, "HlSearchLensNear", { link = "Search" })
        end,
        keys = {
            keymap.normal.lazy("n", function () vim.cmd([[execute('normal! ' . v:count1 . 'n')]]) require("hlslens").start() end, { noremap = true, silent = true, desc = "Find next" }),
            keymap.normal.lazy("N", function () vim.cmd([[execute('normal! ' . v:count1 . 'N')]]) require("hlslens").start() end, { noremap = true, silent = true, desc = "Find previous" }),
        }
    }
}
