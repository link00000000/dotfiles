local M = {}

local function config ()
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup_handlers({
        require('plugins.lsp.generic').setup_handler,
        ['omnisharp'] = require('plugins.lsp.omnisharp-extended').setup_handler,
    })
end

M.spec = {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = config,
    dependencies = {
        require('plugins.mason-lspconfig').spec,
        require('plugins.folding').spec,
        require('plugins.navic').spec,
        require('plugins.telescope').spec,

        require('plugins.cmp-nvim-lsp').spec,
        require('plugins.omnisharp-extended-lsp').spec,
    },
}

return M
