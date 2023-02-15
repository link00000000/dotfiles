local M = {}

M.on_attach = function ()
    local folding = require('folding')

    folding.on_attach()
end

local function config ()
end

M.spec = {
    'pierreglaser/folding-nvim',
    lazy = false,
    config = config,
}

return M
