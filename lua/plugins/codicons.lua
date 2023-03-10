local M = {}

local function config ()
    local codicons = require('codicons')
    codicons.setup()
end

M.spec = {
    'mortepau/codicons.nvim',
    lazy = true,
    config = config,
}

return M
