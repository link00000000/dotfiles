local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "jay-babu/mason-nvim-dap.nvim",
        lazy = true,
        config = function ()
            ---@diagnostic disable-line
            require("mason-nvim-dap").setup({
                handlers = {
                    require("plugins.dap.default").setup_handler,
                }
            })
        end,
        dependencies = {
            require("plugins.nvim-dap").spec,
            require("plugins.mason").spec,
        },
        keys = {
            keymap.normal.lazy("<LEADER>dd", function () require("dap").contine() end, { desc = "Start debug" }),

            keymap.normal.lazy("<LEADER>dn", function () require("dap").step_over() end, { desc = "Step over (next)" }),
            keymap.normal.lazy("<LEADER>di", function () require("dap").step_over() end, { desc = "Step into" }),
            keymap.normal.lazy("<LEADER>do", function () require("dap").step_over() end, { desc = "Step out" }),
            keymap.normal.lazy("<LEADER>do", function () require("dap").step_over() end, { desc = "Step out" }),

            keymap.normal.lazy("<LEADER>db", function () require("dap").step_over() end, { desc = "Toggle breakpoint" }),
        }
    }
}
