local function config ()
    local codicons = require('codicons')
    codicons.setup({})
end

---@type PluginModule
return {
    spec = {
        'mortepau/codicons.nvim',
        lazy = true,
        config = config,
    }
}
