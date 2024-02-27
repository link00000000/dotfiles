local keymap = require("utils.keymap")

local function config ()
    local notify = require("notify")

    ---@diagnostic disable-next-line
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

---@type PluginModule
return {
    spec = {
        "rcarriga/nvim-notify",
        lazy = true,
        config = config,
        cmd = { "Notifications" },
        keys = {
            keymap.normal.lazy("<Leader>nh", "<cmd>Notifications<CR>", { desc = "Show history" }),
            keymap.normal.lazy("<Leader>nd", function () require("notify").dismiss({ pending = true, silent = true }) end, { desc = "Dismiss all" })
        }
    }
}
