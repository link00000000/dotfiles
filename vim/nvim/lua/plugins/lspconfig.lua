---@type PluginModule
return {
    spec = {
        'neovim/nvim-lspconfig',
        dependencies = {
            require("plugins.nvim-notify").spec,

            require('plugins.folding').spec,
            require('plugins.navic').spec,
            require('plugins.barbecue').spec,
            require('plugins.telescope').spec,

            require('plugins.cmp-nvim-lsp').spec,
            require('plugins.omnisharp-extended-lsp').spec,
            require('plugins.neodev').spec,
        },
    }
}
