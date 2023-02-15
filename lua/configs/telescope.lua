-- Requires ripgrep `scoop install ripgrep` Require zig `scoop install zig`
-- Requires fd `scoop install fd`

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

local wide_layout_config = { width = 0.9 }

function themes.get_custom_dropdown(opts)
    local base_theme_opts = themes.get_dropdown()

    local theme_opts = {
        borderchars = {
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        }
    }

    if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
        theme_opts.borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "┌", "┐", "┤", "├" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        }
    end

    return vim.tbl_deep_extend("force", vim.tbl_deep_extend("force", base_theme_opts, theme_opts), opts or {})
end

function themes.get_custom_cursor(opts)
    local base_theme_opts = themes.get_cursor(opts)

    local theme_opts = {
        borderchars = {
            prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        }
    }

    return vim.tbl_deep_extend("force", vim.tbl_deep_extend("force", base_theme_opts, theme_opts), opts or {})
end

function themes.get_custom_ivy(opts)
    local base_theme_opts = themes.get_ivy()

    local theme_opts = {
        borderchars = {
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        }
    }

    if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
        theme_opts.borderchars = {
            prompt = { " ", " ", "─", " ", " ", " ", "─", "─" },
            results = { "─", " ", " ", " ", "─", "─", " ", " " },
            preview = { "─", " ", "─", "│", "┬", "─", "─", "└" },
        }
    end

    return vim.tbl_deep_extend("force", vim.tbl_deep_extend("force", base_theme_opts, theme_opts), opts or {})
end

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
        layout_config = { width = 0.4, prompt_position = "top" },

        path_display = { "truncate" },
        shorten_path = true,
        file_ignore_patterns = { "node_modules" },

        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",

        winblend = 10,
        border = {},
        borderchars = { "─", "│", "─", "│", "┌", "┐", "└", "┘" },
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil
        history = {
            path = vim.fn.stdpath('data') .. '/telescope_smart_history.sqlite3',
            limit = 100
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        },
        ["ui-select"] = {
            themes.get_custom_cursor()
        }
    }
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")
telescope.load_extension("repo")
telescope.load_extension("smart_history")

vim.api.nvim_create_user_command('Repos', 'lua require("telescope").extensions.repo.list(require("telescope.themes").get_custom_dropdown({ search_dirs = { "~/Source/repos" }, tail_path = true, previewer = false }))', {})

-- -- dap exts
-- telescope.load_extension("dap")


local opts = { silent = true }

vim.keymap.set('n', '<C-p>',
    function ()
        builtin.find_files(themes.get_custom_dropdown({ previewer = false }))
    end,
opts)

vim.keymap.set('n', '<C-b>',
    function ()
        builtin.buffers(themes.get_custom_dropdown({ previewer = false, sort_lastused = true }))
    end,
opts)

vim.keymap.set('n', '<C-f>',
    function ()
        builtin.live_grep(themes.get_custom_ivy({ prompt_title = 'Find All', layout_config = wide_layout_config }))
    end,
opts)


