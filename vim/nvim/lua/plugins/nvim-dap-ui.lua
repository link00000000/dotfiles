---@type PluginModule
return {
    spec = {
        "rcarriga/nvim-dap-ui",
        config = function ()
            require("dapui").setup()
        end,
        dependencies = {
            require("plugins.mason-nvim-dap").spec,
            require("plugins.nvim-nio").spec,
        },
    }
}
