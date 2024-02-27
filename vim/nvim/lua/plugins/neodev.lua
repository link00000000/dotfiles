---@type PluginModule
return {
    spec = {
        "folke/neodev.nvim",
        lazy = true,
        config = function ()
            require("neodev").setup({})
        end
    }
}

