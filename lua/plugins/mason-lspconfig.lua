local M = {}

local function config ()
    local mason_lspconfig = require('mason-lspconfig')

    mason_lspconfig.setup()
end

M.spec = {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    config = config,
    dependencies = {
        require('plugins.mason').spec,
    }
}

return M
