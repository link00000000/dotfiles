local M = {}

local function config ()
    local glance = require("glance")
    glance.setup()
end

M.spec = {
    "DNLHC/glance.nvim",
    lazy = true,
    config = config,
    cmd = { "Glance" }
}

return M
