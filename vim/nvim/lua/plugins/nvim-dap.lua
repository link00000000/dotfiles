---@type PluginModule
return
{
    spec = {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function ()
            local dap = require("dap")
            local codicons = require("codicons")

            vim.fn.sign_define("DapBreakpoint", {
                text = codicons.get("circle-filled", "icon"),
                texthl = "Error",
            })

            vim.fn.sign_define("DapBreakpointCondition", {
                text = codicons.get("debug-breakpoint-conditional", "icon"),
                texthl = "Error",
            })

            vim.fn.sign_define("DapLogPoint", {
                text = codicons.get("debug-breakpoint-log", "icon"),
                texthl = "Error",
            })

            vim.fn.sign_define("DapStopped", {
                text = codicons.get("arrow-right", "icon"),
                texthl = "WarningMsg",
                linehl = "Search",
            })

            vim.fn.sign_define("DapRejected", {
                text = codicons.get("circle-filled", "icon"),
                texthl = "BufferOffset",
            })
        end,
        dependencies = {
            require("plugins.codicons").spec,
        }
    }
}
