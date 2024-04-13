--- @type PluginModule
return {
    spec = {
        "luukvbaal/statuscol.nvim",
        config = function ()
            require("statuscol").setup()
        end
    }
}
