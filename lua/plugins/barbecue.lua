local M = {}

local function config ()
    local barbecue = require('barbecue')
    barbecue.setup()
end

M.spec = {
    "utilyre/barbecue.nvim",
    lazy = true,
    config = config,
    dependencies = {
        require('plugins.navic').spec,
    },
}

return M
