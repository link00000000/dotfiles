local keymap = require('utils.keymap')

local M = {}

local border_chars = {
    EMPTY      = ' ',
    HORIZONTAL = '─',
    VERTICAL   = '│',
    CORNER_NW  = '┌',
    CORNER_NE  = '┐',
    CORNER_SW  = '└',
    CORNER_SE  = '┘',
    T_TOP      = '┴',
    T_RIGHT    = '├',
    T_BOTTOM   = '┬',
    T_LEFT     = '┤',
}

M.themes = {
    dropdown = function (opts)
        local telescope_themes = require('telescope.themes')

        local base_theme_opts = telescope_themes.get_dropdown()

        local theme_opts = {
            borderchars = {
                prompt = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.EMPTY, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.VERTICAL, border_chars.VERTICAL },
                results = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.T_RIGHT, border_chars.T_LEFT, border_chars.CORNER_SE, border_chars.CORNER_SW },
                preview = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.CORNER_SE, border_chars.CORNER_SW },
            }
        }

        if opts.layout_config and opts.layout_config.prompt_position == 'bottom' then
            theme_opts.borderchars = {
                prompt = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.CORNER_SE, border_chars.CORNER_SW },
                results = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.T_LEFT, border_chars.T_RIGHT },
                preview = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.CORNER_SE, border_chars.CORNER_SW },
            }
        end

        return vim.tbl_deep_extend('force', vim.tbl_deep_extend('force', base_theme_opts, theme_opts), opts or {})
    end,

    cursor = function (opts)
        local telescope_themes = require('telescope.themes')

        local base_theme_opts = telescope_themes.get_cursor(opts)

        local theme_opts = {
            borderchars = {
                prompt = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.EMPTY, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.VERTICAL, border_chars.VERTICAL },
                results = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.T_RIGHT, border_chars.T_LEFT, border_chars.CORNER_SE, border_chars.CORNER_SW },
                preview = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.CORNER_SE, border_chars.CORNER_SW },
            }
        }

        return vim.tbl_deep_extend('force', vim.tbl_deep_extend('force', base_theme_opts, theme_opts), opts or {})
    end,

    ivy = function (opts)
        local telescope_themes = require('telescope.themes')

        local base_theme_opts = telescope_themes.get_ivy()

        local theme_opts = {
            borderchars = {
                prompt = { border_chars.HORIZONTAL, border_chars.EMPTY, border_chars.EMPTY, border_chars.EMPTY, border_chars.HORIZONTAL, border_chars.HORIZONTAL, border_chars.EMPTY, border_chars.EMPTY },
                results = { border_chars.EMPTY },
                preview = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.CORNER_SE, border_chars.CORNER_SW },
            }
        }

        if opts.layout_config and opts.layout_config.prompt_position == 'bottom' then
            theme_opts.borderchars = {
                prompt = { border_chars.EMPTY, border_chars.EMPTY, border_chars.HORIZONTAL, border_chars.EMPTY, border_chars.EMPTY, border_chars.EMPTY, border_chars.HORIZONTAL, border_chars.HORIZONTAL },
                results = { border_chars.HORIZONTAL, border_chars.EMPTY, border_chars.EMPTY, border_chars.EMPTY, border_chars.HORIZONTAL, border_chars.HORIZONTAL, border_chars.EMPTY, border_chars.EMPTY },
                preview = { border_chars.HORIZONTAL, border_chars.EMPTY, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.T_BOTTOM, border_chars.HORIZONTAL, border_chars.HORIZONTAL, border_chars.CORNER_SW },
            }
        end

        return vim.tbl_deep_extend('force', vim.tbl_deep_extend('force', base_theme_opts, theme_opts), opts or {})
    end,
}

M.find_file = function ()
    local telescope_builtin = require('telescope.builtin')
    telescope_builtin.find_files(M.themes.dropdown({ previewer = false }))
end

M.find_buffer = function ()
    local telescope_builtin = require('telescope.builtin')
    telescope_builtin.buffers(M.themes.dropdown({ previewer = false, sort_lastused = true }))
end

M.search_all_files = function ()
    local telescope_builtin = require('telescope.builtin')
    local telescope_state = require('telescope.state')

    local cached_pickers = telescope_state.get_global_key('cached_pickers') or {}
    local cached_search_all_files_picker_index = nil

    for i, cached_picker in ipairs(cached_pickers) do
        if cached_picker.prompt_title == 'Find All' then
            cached_search_all_files_picker_index = i
        end
    end

    if cached_search_all_files_picker_index ~= nil then
        telescope_builtin.resume({ cache_index = cached_search_all_files_picker_index })
    else
        telescope_builtin.live_grep(M.themes.ivy({ prompt_title = 'Find All', cache_picker = { num_pickers = 1, limit_entries = 1000 } }))
    end
end

M.find_repos = function ()
    local telescope = require('telescope')
    -- TODO: Figure out why repos list is empty
    telescope.extensions.repo.list(M.themes.dropdown({ search_dirs = { 'C:/Users/crand/source' }, tail_path = true, previewer = false }))
end

local function setup_commands ()
    local command = require('utils.command')
    command.create('Files', M.find_file)
    command.create('Buffers', M.find_buffer)
    command.create('Find', M.search_all_files)
    command.create('Repos', M.find_repos)
end

local function config ()
    local telescope = require('telescope')
    local telescope_actions = require('telescope.actions')
    local codicons = require('codicons')
    local path = require('utils.path')

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ['<C-j>']   = telescope_actions.move_selection_next,
                    ['<C-k>']   = telescope_actions.move_selection_previous,
                    ['<C-S-k>'] = telescope_actions.cycle_history_prev,
                    ['<C-S-j>'] = telescope_actions.cycle_history_next,
                    ['<ESC>']   = telescope_actions.close,
                },
            },

            layout_strategy = 'horizontal',
            layout_config = { width = 0.4, prompt_position = 'top' },

            path_display = { 'truncate' },
            shorten_path = true,
            file_ignore_patterns = { 'node_modules' },

            prompt_prefix = ' ' .. codicons.get('search') .. '   ',
            selection_caret = '  ',
            entry_prefix = '  ',

            winblend = 10,
            border = {},
            borderchars = { border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.HORIZONTAL, border_chars.VERTICAL, border_chars.CORNER_NW, border_chars.CORNER_NE, border_chars.CORNER_SW, border_chars.CORNER_SE },
            set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil
            history = {
                path = path.resolve_nvim_data_dir_path('telescope_smart_history.sqlite3'),
                limit = 100,
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case'
            },
            ['ui-select'] = {
                M.themes.cursor()
                -- require('telescope.themes').get_dropdown()
            },
        },
    })

    telescope.load_extension('fzf')
    -- telescope.load_extension('ui-select')
    telescope.load_extension('repo')
    telescope.load_extension('smart_history')

    setup_commands()
end

M.spec = {
    'nvim-telescope/telescope.nvim',
    version = '0.1.0',
    lazy = true,
    config = config,
    keys = {
        keymap.normal.lazy('<C-p>', M.find_file, { desc = 'Find file' }),
        keymap.normal.lazy('<C-b>', M.find_buffer, { desc = 'Find buffer' }),
        keymap.normal.lazy('<C-f>', M.search_all_files, { desc = 'Search all files' }),
    },
    cmd = { 'Telescope', 'Files', 'Buffers', 'Find', 'Repos' },
    dependencies = {
        require('plugins.plenary').spec,
        -- require('plugins.telescope-ui-select').spec,
        require('plugins.telescope-fzf-native').spec,
        require('plugins.telescope-repo').spec,
        require('plugins.telescope-smart-history').spec,
        require('plugins.codicons').spec,
    },
}

return M
