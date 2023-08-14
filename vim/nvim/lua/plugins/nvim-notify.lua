local M = {}

local function config ()
    local notify = require("notify")
    notify.setup({
        render = "compact",
        fps = 120,
        timeout = 0,
        stages = "fade_in_slide_out",
        icons = {
            DEBUG = " ",
            ERROR = " ",
            INFO = " ",
            TRACE = " ✎",
            WARN = " "
        }
    })

    vim.notify = notify
end

M.spec = {
    "rcarriga/nvim-notify",
    lazy = true,
    config = config,
    cmd = { "Notifications" }
}

return M
