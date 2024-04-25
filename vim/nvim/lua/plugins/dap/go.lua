local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "leoluz/nvim-dap-go",
        lazy = true,
        ft = { "go", "gomod" },
        config = function ()
            require("dap-go").setup({
                delve = {
                    path = vim.fn.exepath("dlv")
                },
            })
        end,
        keys = {
            keymap.normal.lazy("<Leader>dt", function () require("dap-go").debug_test() end, { desc = "Debug Test" }),
        },
        dependencies = {
            require("plugins.mason-nvim-dap").spec,
        }
    },
}
