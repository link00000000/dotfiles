local M = {}

local function config ()
end

M.spec = {
    'nvim-telescope/telescope-smart-history.nvim',
    lazy = false,
    config = config,
    dependencies = {
        require('plugins.sqlite').spec,
    },
}

return M
