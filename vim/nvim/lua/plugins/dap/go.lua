local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "leoluz/nvim-dap-go",
        lazy = true,
        ft = { "go", "gomod" },
        config = function ()
            require("dap-go").setup()
        end,
        keys = {
            keymap.normal.lazy("<Leader>dt", function () require("dap-go").debug_test() end, { desc = "Debug Test" }),
        }
    }
}
