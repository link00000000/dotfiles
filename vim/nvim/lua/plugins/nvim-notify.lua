local keymap = require("utils.keymap")

---@type PluginModule
return {
    spec = {
        "rcarriga/nvim-notify",
        lazy = true,
        config = function ()
            local notify = require("notify")

            ---@diagnostic disable-next-line
            notify.setup({
                render = "default",
                timeout = 5,
                stages = "fade",
                level = "error",
                icons = {
                    DEBUG = " ",
                    ERROR = " ",
                    INFO = " ",
                    TRACE = " ✎",
                    WARN = " "
                },
                top_down = false,
            })

            vim.notify = notify
        end,
        cmd = { "Notifications" },
        keys = {
            keymap.normal.lazy("<Leader>nh", function () require("telescope").extensions.notify.notify() end, { desc = "Show history" }),
            keymap.normal.lazy("<Leader>nd", function () require("notify").dismiss({ pending = true, silent = true }) end, { desc = "Dismiss all" })
        },
    }
}
