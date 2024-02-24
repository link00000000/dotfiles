local function config ()
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup()

    mason_lspconfig.setup_handlers({
        require('plugins.lsp.generic').setup_handler,
        ['omnisharp'] = require('plugins.lsp.omnisharp-extended').setup_handler,
        ['lua_ls'] = require("plugins.lsp.neodev").setup_handler,
        ['grammarly'] = require("plugins.lsp.grammarly").setup_handler,
    })
end

---@type PluginModule
return {
    spec = {
        'williamboman/mason-lspconfig.nvim',
        config = config,
        dependencies = {
            require("plugins.mason").spec,
            require("plugins.lspconfig").spec,
        }
    }
}
