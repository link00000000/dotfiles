local function config ()
    -- require("plugins.lsp.autohotkey").register_with_lspconfig()

    require("mason-lspconfig").setup({
        handlers = {
            require('plugins.lsp.default').setup_handler,
            ['omnisharp'] = require('plugins.lsp.omnisharp-extended').setup_handler,
            ['grammarly'] = require("plugins.lsp.grammarly").setup_handler,
        }
    })
    
    -- require("lspconfig").ahk2.setup(require("plugins.lsp.default").setup_handler)
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
