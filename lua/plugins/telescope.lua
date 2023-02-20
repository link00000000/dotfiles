local keymap = require('utils.keymap')

local M = {}

local function find_file ()
    local telescope_builtin = require('telescope.builtin')
    telescope_builtin.find_files() -- TODO:
    --builtin.find_files(themes.get_custom_dropdown({ previewer = false }))
end

local function find_buffer ()
    local telescope_builtin = require('telescope.builtin')
    telescope_builtin.buffers() -- TODO:
    -- builtin.buffers(themes.get_custom_dropdown({ previewer = false, sort_lastused = true }))
end

local function search_all_files ()
    local telescope_builtin = require('telescope.builtin')
    telescope_builtin.live_grep() -- TODO:
    -- builtin.live_grep(themes.get_custom_ivy({ prompt_title = 'Find All', layout_config = wide_layout_config }))
end

local function find_repos ()
    local telescope = require('telescope')
    telescope.extensions.repo.list({ search_dirs = { "~/Source/repos" }, tail_path = true, previewer = false })
    --vim.api.nvim_create_user_command('Repos', 'lua require("telescope").extensions.repo.list(require("telescope.themes").get_custom_dropdown({ search_dirs = { "~/Source/repos" }, tail_path = true, previewer = false }))', {})
end

local function setup_commands ()
    local command = require('utils.command')
    command.create('Files', find_file)
    command.create('Buffers', find_buffer)
    command.create('Find', search_all_files)
    command.create('Repos', find_repos)
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

            prompt_prefix = ' ' .. codicons.get('search') .. '  ',
            selection_caret = '  ',
            entry_prefix = '  ',

            winblend = 10,
            border = {},
            borderchars = { '─', '│', '─', '│', '┌', '┐', '└', '┘' },
            set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil
            history = {
                path = path.get_nvim_data_dir('telescope_smart_history.sqlite3'),
                limit = 100
            }
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case'
            },
            ['ui-select'] = {
                --themes.get_custom_cursor()
                require('telescope.themes').get_dropdown()
            },
        },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension('repo')
    telescope.load_extension('smart_history')

    setup_commands()
end

M.spec = {
    'nvim-telescope/telescope.nvim',
    version = '0.1.0',
    lazy = false, -- TODO: Lazy load
    config = config,
    keys = {
        keymap.normal.lazy('<C-p>', find_file, { desc = 'Find file' }),
        keymap.normal.lazy('<C-b>', find_buffer, { desc = 'Find buffer' }),
        keymap.normal.lazy('<C-f>', search_all_files, { desc = 'Search all files' }),
    },
    cmd = { 'Repos' }, -- TODO: Add more commands
    dependencies = {
        require('plugins.plenary').spec,
        require('plugins.telescope-ui-select').spec,
        require('plugins.telescope-fzf-native').spec,
        require('plugins.telescope-repo').spec,
        require('plugins.telescope-smart-history').spec,
        require('plugins.codicons').spec,
    },
}

return M
