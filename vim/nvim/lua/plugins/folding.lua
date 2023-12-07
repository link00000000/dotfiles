local on_attach = function ()
    local folding = require('folding')

    folding.on_attach()
end

local function config ()
end

---@type PluginModule
return {
    spec = {
        'pierreglaser/folding-nvim',
        lazy = true,
        config = config,
    },
    on_attach = on_attach
}
