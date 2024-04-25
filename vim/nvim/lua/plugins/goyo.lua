local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "junegunn/goyo.vim",
        cmd = { "Goyo" },
        keys = keymap.normal.lazy("<C-w>zz", "Goyo", { desc = "Toggle Goyo " }),
    },
}
