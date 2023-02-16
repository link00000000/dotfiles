local M = {}

M.on_attach = function (client, bufnr)
    local navic = require('nvim-navic')

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

local function config ()
end

M.spec = {
    'SmiteshP/nvim-navic',
    lazy = false,
    config = config,
}

return M
