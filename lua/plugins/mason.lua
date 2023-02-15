local M = {}

local function config ()
    local mason = require('mason')

    mason.setup()
end

M.spec = {
    'williamboman/mason.nvim',
    lazy = false,
    config = config,
}

return M
