local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "tpope/vim-fugitive",
        lazy = true,
        event = { "VeryLazy" },
        keys = {
            keymap.normal.lazy("<Leader>gg", "<cmd>Git<CR>", { desc = "Toggle Git" }),
            keymap.normal.lazy("<Leader>gb", "<cmd>Git blame<CR>", { desc = "Toggle Blame" }),
        },
    }
}
