local function config ()
    local barbecue = require('barbecue')
    barbecue.setup()
end

---@type PluginModule
return {
    spec = {
        "utilyre/barbecue.nvim",
        lazy = true,
        config = config,
        dependencies = {
            require('plugins.navic').spec,
        },
    }
}
