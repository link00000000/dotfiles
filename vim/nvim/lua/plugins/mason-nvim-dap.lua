local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "jay-babu/mason-nvim-dap.nvim",
        lazy = false,
        keys = {
            keymap.normal.lazy("<Leader>dx", function () require("projector").continue() end, { desc = "Start debuging (\"Debug eXecute\")" }),
            keymap.normal.lazy("<F5>", function () require("projector").continue() end, { desc = "Start debugging" }),
            keymap.normal.lazy("<Leader>ds", function () require("dap").stop() end, { desc = "Stop debugging" }),

            keymap.normal.lazy("<Leader>dn", function () require("dap").step_over() end, { desc = "Step over (\"Debug Next\")" }),
            keymap.normal.lazy("<Leader>di", function () require("dap").step_into() end, { desc = "Step into (\"Debug Into\")" }),
            keymap.normal.lazy("<Leader>do", function () require("dap").setup_out() end, { desc = "Step out (\"Debug Out of\")" }),
            keymap.normal.lazy("<Leader>dh", function () require("dap").run_to_cursor() end, { desc = "Run to cursor (\"Debug to Here\")" }),

            keymap.normal.lazy("<Leader>db", function () require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" }),
        },
        config = function ()
            ---@diagnostic disable-next-line
            require("mason-nvim-dap").setup({
                handlers = {
                    require("plugins.dap.default").setup_handler,
                    delve = require("plugins.dap.go").setup_handler,
                },
            })
        end,
        dependencies = {
            require("plugins.nvim-dap").spec,
            require("plugins.mason").spec,
            require("plugins.nvim-dap-virtual-text").spec,
            require("plugins.nvim-projector").spec,
        },
    }
}
