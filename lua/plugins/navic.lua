local file = require('utils.file')

local M = {}

M.on_attach = function (client, bufnr)
    local navic = require('nvim-navic')

    file.write('C:/Users/lcrandall/Downloads/on_attach.log', 'navic on_attach')

    if client.server_capabilities.documentSymbolProvider then
        file.write('C:/Users/lcrandall/Downloads/on_attach.log', 'navic condition passed')

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
