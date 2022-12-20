-- Requires ripgrep `scoop install ripgrep`
-- Require zig `scoop install zig`
-- Requires fd `scoop install fd`

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<C-p>"] = require('telescope.actions').cycle_history_prev,
                ["<C-n>"] = require('telescope.actions').cycle_history_next,
                ["<ESC>"] = require('telescope.actions').close,
            }
        },

        layout_strategy = "horizontal",
        layout_config = { width = 0.4, anchor = "N", prompt_position = "top" },

        path_display = { "truncate" },
        shorten_path = true,
        file_ignore_patterns = { "node_modules" },

        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",

        winblend = 10,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        },
        ["ui-select"] = {
            themes.get_dropdown {
                -- even more opts
            }
        }
    }
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("repo")

vim.api.nvim_create_user_command('Repos', 'lua require("telescope").extensions.repo.list(require("telescope.themes").get_dropdown({ search_dirs = { "~/Source/repos" }, tail_path = true, previewer = false }))', {})

-- -- dap exts
-- telescope.load_extension("dap")


local opts = { silent = true }

vim.keymap.set('n', '<C-p>',
    function()
        builtin.find_files(themes.get_dropdown({ previewer = false }))
    end,
opts)

vim.keymap.set('n', '<C-b>',
    function()
        builtin.buffers(themes.get_dropdown({ previewer = false, sort_lastused = true }))
    end,
opts)

vim.keymap.set('n', '<C-f>',
    function()
        builtin.live_grep(themes.get_dropdown({ prompt_title = 'Find', search_dirs = { "%:p" } }))
    end,
opts)

vim.keymap.set('n', '<C-S-f>',
    function()
        builtin.live_grep(themes.get_dropdown({ prompt_title = 'Find All' }))
    end,
opts)

vim.keymap.set('n', '<C-S-p>',
    function()
        builtin.commands();
    end,
opts)


