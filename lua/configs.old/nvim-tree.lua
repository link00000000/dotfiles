local nvim_tree = require('nvim-tree')
local nvim_tree_api = require('nvim-tree.api')
local codicons = require('codicons')

nvim_tree.setup({
    sort_by = "case_sensitive",
    sync_root_with_cwd = true,
    view = {
        adaptive_size = true,
        mappings = {
            custom_only = true,
            list = {
                { key = { "<CR>", "l", "<2-LeftMouse>" },      action = "edit" },
                { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" },
                { key = "v",                              action = "vsplit" },
                { key = "s",                              action = "split" },
                { key = "t",                              action = "tabnew" },
                { key = "h",                              action = "close_node" },
                { key = "<Tab>",                          action = "preview" },
                { key = "K",                              action = "first_sibling" },
                { key = "J",                              action = "last_sibling" },
                { key = "C",                              action = "toggle_git_clean" },
                { key = "I",                              action = "toggle_git_ignored" },
                { key = "H",                              action = "toggle_dotfiles" },
                { key = "B",                              action = "toggle_no_buffer" },
                { key = "U",                              action = "toggle_custom" },
                { key = "R",                              action = "refresh" },
                { key = "n",                              action = "create" },
                { key = "D",                              action = "remove" },
                { key = "r",                              action = "rename" },
                { key = "c",                              action = "copy" },
                { key = "x",                              action = "cut" },
                { key = "p",                              action = "paste" },
                { key = "y",                              action = "copy_name" },
                { key = "Y",                              action = "copy_path" },
                { key = "-",                              action = "dir_up" },
                { key = "f",                              action = "live_filter" },
                { key = "F",                              action = "clear_live_filter" },
                { key = "q",                              action = "close" },
                { key = "S",                              action = "search_node" },
                { key = ".",                              action = "run_file_command" },
                { key = "<C-k>",                          action = "toggle_file_info" },
                { key = "g?",                             action = "toggle_help" },
                { key = "<Space>",                        action = "toggle_mark" },
                { key = "bmv",                            action = "bulk_move" },
            }
        }
    },
    update_focused_file = {
        enable = true,
    },
    renderer = {
        group_empty = true,
        icons = {
            webdev_colors = true,
            git_placement = "after",
            modified_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
                modified = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "",
                modified = "●",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "",
                    unmerged = "",
                    renamed = codicons.get('diff-renamed'),
                    untracked = codicons.get('diff-added'),
                    deleted = codicons.get('diff-removed'),
                    ignored = codicons.get('diff-ignored'),
                },
            },
        },
    },
    filters = {
        dotfiles = false,
    }
})

local opts = { silent = true }

vim.keymap.set('n', '<Leader>ff',
    function ()
        nvim_tree.open()
    end,
opts)

vim.keymap.set('n', '<Leader>fn',
    function ()
        nvim_tree_api.fs.create()
    end,
opts)

vim.keymap.set('n', '<Leader>fd',
    function ()
        nvim_tree_api.fs.remove()
    end,
opts)
