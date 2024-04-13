--- @type PluginModule
return {
    spec = {
        "theHamsta/nvim-dap-virtual-text",
        config = function ()
            require("nvim-dap-virtual-text").setup()
        end,
    }
}
