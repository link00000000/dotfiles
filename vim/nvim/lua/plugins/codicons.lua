---@type PluginModule
return {
    spec = {
        'mortepau/codicons.nvim',
        lazy = true,
        config = function ()
            require("codicons").setup()
        end,
    }
}
