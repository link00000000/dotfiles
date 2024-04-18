---@type PluginModule
return {
    spec = {
        "rcarriga/nvim-dap-ui",
        config = function ()
            require("dapui").setup()

            local dap = require("dap")
            local dapui = require("dapui")

            -- Automatically open and close dapui when debugging starts and stops
            dap.listeners.before.attach.dapui = dapui.open
            dap.listeners.before.launh.dapui = dapui.open
            dap.listeners.before.event_terminated.dapui = dapui.close
            dap.listeners.before.event_exited.dapui = dapui.close

            vim.keymap.set("n", "<Leader>duo", function () require("dapui").open() end, { desc = "Open DAP UI (Dap Ui Open)" })
            vim.keymap.set("n", "<Leader>duc", function () require("dapui").close() end, { desc = "Close DAP UI (Dap Ui Close)" })

            vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { link = "Comment" })
        end,
        dependencies = {
            require("plugins.mason-nvim-dap").spec,
            require("plugins.nvim-nio").spec,
            require("plugins.mason-nvim-dap").spec,
        },
    }
}
