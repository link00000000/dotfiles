local function config ()
    require("mason-lspconfig").setup({
        handlers = {
            require('plugins.lsp.default').setup_handler,
            -- ['omnisharp'] = require('plugins.lsp.omnisharp-extended').setup_handler,
            -- ['lua_ls'] = require("plugins.lsp.neodev").setup_handler,
            -- ['grammarly'] = require("plugins.lsp.grammarly").setup_handler,
        }
    })

    -- error(vim.inspect(require("plugins.lsp.default").setup_handler("lua_ls")))
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
