local M = {}

local function config ()
    local notify = require("notify")
    notify.setup()

    vim.notify = notify
end

M.spec = {
    "rcarriga/nvim-notify",
    lazy = true,
    config = config,
    cmd = { "Notifications" }
}

return M
