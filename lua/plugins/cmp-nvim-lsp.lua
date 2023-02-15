local M = {}

M.get_default_capabilities = function ()
    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    return cmp_nvim_lsp.default_capabilities()
end

M.spec = {
    'hrsh7th/cmp-nvim-lsp',
    lazy = false,
    config = function ()
    end
}

return M
