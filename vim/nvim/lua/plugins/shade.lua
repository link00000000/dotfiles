local M = {}

local function config ()
    local shade = require("shade")

    shade.setup({})
end

M.spec = {
    'sunjon/shade.nvim',
    lazy = true,
    config = config,
    event = { "BufEnter" }
}

return M
