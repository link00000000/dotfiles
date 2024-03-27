---@type PluginModule
return {
    spec = {
        "kndndrj/nvim-projector",
        dependencies = {
            require("plugins.nui").spec,
        },
        config = function ()
            require("projector").setup({})
        end
    }
}
