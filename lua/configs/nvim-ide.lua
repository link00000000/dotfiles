local nvim_ide = require('ide')
local outline = require('ide.components.outline')
local explorer = require('ide.components.explorer')
local terminal_browser = require('ide.components.terminal.terminalbrowser')
local call_hierarchy = require('ide.components.callhierarchy')
local changes = require('ide.components.changes')
local branches = require('ide.components.branches')
local terminal = require('ide.components.terminal')

nvim_ide.setup({
    icon_set = "codicons",
    components = {
        global_keymaps = {
            hide = "<NOP>",
            close = "<NOP>",
        },
        BufferList = {
            current_buffer_top = true,
        },
        Terminal = {
            shell = vim.opt.shell:get() or os.getenv("SHELL") or "powershell.exe",
        },
        Explorer = {
            list_directories_first = true,
            show_file_permissions = false,
            keymaps = {
                expand = "l",
                collapse = "h"
            },
        },
    },
    panels = {
        left = "explorer",
        right = "git"
    },
    panel_groups = {
        explorer = { outline.Name, explorer.Name, call_hierarchy.Name, terminal_browser.Name },
        git = { changes.Name, branches.Name },
        terminal = { terminal.Name },
    },
    workspaces = {
        auto_open = 'none',
    }
})

local opts = { silent = true }
vim.api.nvim_set_keymap("n", "<Leader><Leader>", ":Workspace<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ff", ":Workspace Explorer Focus<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>bb", ":Workspace BufferList Focus<CR>", opts)
vim.api.nvim_set_keymap("n", "`", ":Workspace BottomPanelToggle<CR>", opts)
