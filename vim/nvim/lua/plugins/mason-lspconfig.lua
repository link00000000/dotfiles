local function config ()
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup()
end

---@type PluginModule
return {
    spec = {
        'williamboman/mason-lspconfig.nvim',
        lazy = true,
        config = config,
        dependencies = {
            require('plugins.mason').spec,
        }
    }
}
