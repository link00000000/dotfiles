local M = {}

local function config ()
    local neodev = require("neodev")
    neodev.setup({
        lspconfig = false,
    })
end

M.spec = {
    "folke/neodev.nvim",
    config = config,
    lazy = true
}

return M
