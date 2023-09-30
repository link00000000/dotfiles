local M = {}

local function config ()
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup_handlers({
        require('plugins.lsp.generic').setup_handler,
        ['omnisharp'] = require('plugins.lsp.omnisharp-extended').setup_handler,
        ['lua_ls'] = require("plugins.lsp.neodev").setup_handler,
    })
end

M.spec = {
    'neovim/nvim-lspconfig',
    lazy = true,
    config = config,
    event = { "BufEnter" },
    dependencies = {
        require("plugins.nvim-notify").spec,

        require('plugins.mason-lspconfig').spec,
        require('plugins.folding').spec,
        require('plugins.navic').spec,
        require('plugins.barbecue').spec,
        require('plugins.telescope').spec,

        require('plugins.cmp-nvim-lsp').spec,
        require('plugins.omnisharp-extended-lsp').spec,
        require('plugins.neodev').spec,
    },
}

return M
