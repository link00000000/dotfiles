local M = {}

local function config ()
    local surround = require("nvim-surround")
    surround.setup()
end

M.spec = {
    "kylechui/nvim-surround",
    config = config,
    event = { "VeryLazy" },
}

return M
