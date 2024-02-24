-- The config function must be specified for this plugin because lazy.nvim cannot figure out which file to require to call setup
local function config ()
    require("ibl").setup()
end

---@type PluginModule
return {
    spec = {
        "lukas-reineke/indent-blankline.nvim",
        config = config
    }
}
