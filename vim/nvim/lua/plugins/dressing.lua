---@type PluginModule
return {
    spec = {
        "stevearc/dressing.nvim",
        config = function ()
            require("dressing").setup({})
        end
    }
}
