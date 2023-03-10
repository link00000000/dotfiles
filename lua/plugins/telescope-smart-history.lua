local M = {}

local function config ()
end

M.spec = {
    'nvim-telescope/telescope-smart-history.nvim',
    lazy = true,
    config = config,
    dependencies = {
        require('plugins.sqlite').spec,
    },
}

return M
