local command = require('utils.command')

local function config ()
    local rest = require('rest-nvim')

    rest.setup({})
end

return {
    "rest-nvim/rest.nvim",
    lazy = false, -- TODO: Make lazy
    config = config,
}
