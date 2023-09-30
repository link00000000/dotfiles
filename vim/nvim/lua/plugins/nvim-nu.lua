local M = {}

local function config ()
    local nu = require("nu")
end

M.spec = {
    "LhKipp/nvim-nu",
    config = config,
    build = ":TSInstall nu"
}

return M
