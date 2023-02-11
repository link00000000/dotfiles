local alpha = require('alpha')
local dashboard_theme = require('alpha.themes.dashboard')

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
                dashboard_theme.button("n", "  New file", "<cmd>ene <CR>"),
                dashboard_theme.button("r", "  Open repository", "<cmd>Repos <CR>"),
                dashboard_theme.button("f", "  Find file", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_custom_dropdown())<CR>"),
                dashboard_theme.button("s", "  Settings", "<cmd>ConfigCwd<CR>"),
                dashboard_theme.button("q", "  Close", ":q<CR>"),
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
