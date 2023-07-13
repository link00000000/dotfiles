local M = {}

local function config ()
    local alpha = require("alpha")
    local dashboard_theme = require("alpha.themes.dashboard")
    local codicons = require("codicons")

    alpha.setup({
        layout = {
            {
                type = "padding",
                val = 2
            },
            {
                type = "text",
                val = {
                    [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
                    [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
                    [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
                    [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
                    [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
                    [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
                },
                opts = {
                    position = "center",
                    hl = "Type",
                },
            },
            {
                type = "padding",
                val = 2,
            },
            {
                type = "group",
                val = {
                    dashboard_theme.button("n", codicons.get("new-file") .. "  New file", "<cmd>enew<CR>"),
                    dashboard_theme.button("r", codicons.get("repo-forked") .. "  Open repository", "<cmd>Repos<CR>"),
                    dashboard_theme.button("f", codicons.get("search") .. "  Find file", "<cmd>Files<CR>"),
                    dashboard_theme.button("s", codicons.get("settings-gear") .. "  Settings", "<cmd>ConfigCwd<CR>"),
                    dashboard_theme.button("q", codicons.get("close-all") .. "  Close", ":q<CR>"),
                },
                opts = {
                    spacing = 1,
                },
            },
            {
                type = "text",
                val = "",
                opts = {
                    position = "center",
                    hl = "Number",
                },
            }
        },
        opts = {
            margin = 5,
        },
    })
end

M.spec = {
    "goolord/alpha-nvim",
    lazy = true,
    config = config,
    dependencies = {
        require("plugins.nvim-web-devicons").spec,
        require("plugins.codicons").spec
    },
    event = "VimEnter",
    cmd = { "Alpha" }
}

return M
