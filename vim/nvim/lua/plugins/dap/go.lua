local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "leoluz/nvim-dap-go",
        lazy = true,
        ft = { "go", "gomod" },
        config = function ()
            require("dap-go").setup({
                -- delve = vim.tbl_deep_extend("force", require("mason-nvim-dap.mappings.adapters.delve"), {
                --     detached = false,
                -- })
                dap_configurations = {
                    {
                        type = "go",
                        name = "TEST",
                        request = "launch",
                        program = "${file}",
                        -- console = "internalConsole"
                        console = "integratedTerminal"
                    },
                },
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
