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
                    [[                                                                       ]],
                    [[                                                                     ]],
                    [[       ████ ██████           █████      ██                     ]],
                    [[      ███████████             █████                             ]],
                    [[      █████████ ███████████████████ ███   ███████████   ]],
                    [[     █████████  ███    █████████████ █████ ██████████████   ]],
                    [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
                    [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
                    [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
                    [[                                                                       ]],
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
                    dashboard_theme.button("n", codicons.get("new-file", "icon") ..         "  New file", "<cmd>enew<CR>"),
                    dashboard_theme.button("w", codicons.get("notebook", "icon") ..         "  Wiki", "<cmd>VimwikiIndex<CR>"),
                    dashboard_theme.button("r", codicons.get("repo-forked", "icon") ..      "  Open repository", "<cmd>Repos<CR>"),
                    dashboard_theme.button("f", codicons.get("search", "icon") ..           "  Find file", "<cmd>Files<CR>"),
                    dashboard_theme.button("s", codicons.get("settings-gear", "icon") ..    "  Settings", "<cmd>ConfigCwd<CR>"),
                    dashboard_theme.button("q", codicons.get("close-all", "icon") ..        "  Close", ":q<CR>"),
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

---@type PluginModule
return {
    spec = {
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
}
