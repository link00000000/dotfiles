local keymap = require('utils.keymap')

local open_find_files = function ()
    require("telescope.builtin").find_files(require("telescope.themes").get_dropdown())
end

local open_buffers = function ()
    require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ sort_mru = true, select_current = true, }))
end

-- TODO: make sure this still works
local open_live_grep = function ()
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
        telescope_builtin.live_grep(require("telescope.themes").get_ivy({ prompt_title = 'Find All', cache_picker = { num_pickers = 1, limit_entries = 1000 } }))
    end
end

---@type PluginModule
return {
    spec = {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        config = function ()
            local telescope = require('telescope')
            local telescope_actions = require('telescope.actions')
            local codicons = require('codicons')

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"]   = telescope_actions.move_selection_next,
                            ["<C-k>"]   = telescope_actions.move_selection_previous,
                            ["<ESC>"]   = telescope_actions.close,

                            ["<PageUp>"]    = telescope_actions.preview_scrolling_up,
                            ["<PageDown>"]  = telescope_actions.preview_scrolling_down,
                        },
                    },

                    path_display = { 'truncate' },
                    shorten_path = true,
                    file_ignore_patterns = { 'node_modules' },

                    prompt_prefix = ' ' .. codicons.get("search", "icon") .. '    ',
                    selection_caret = ' ',
                    entry_prefix = ' ',

                    winblend = 10,
                    border = {},
                    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil
                },

                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case'
                    },
                    ['ui-select'] = {
                        require("telescope.themes").get_cursor()
                    },
                },
            })

            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')
            telescope.load_extension("dap")
            telescope.load_extension("notify")
        end,
        keys = {
            keymap.normal.lazy('<C-p>', open_find_files, { desc = 'File search' }),
            keymap.normal.lazy('<C-b>', open_buffers, { desc = 'Buffer search' }),
            keymap.normal.lazy('<C-f>', open_live_grep, { desc = 'Text search' }),
            keymap.normal.lazy("<F12>", "<cmd>Telescope<CR>"),

            keymap.normal.lazy("<Leader>dd", "<cmd>Telescope dap commands<CR>", { desc = "Show all debuging commands" }),
            keymap.normal.lazy("<Leader>df", "<cmd>Telescope dap frames<CR>", { desc = "Show stack frames (\"Debug stack Frames\")" }),
            keymap.normal.lazy("<Leader>dv", "<cmd>Telescope dap variables<CR>", { desc = "Show variables (\"Debug Variables\")" }),
            keymap.normal.lazy("<Leader>dl", "<cmd>Telescope dap list_breakpoints<CR>", { desc = "List breakpoints (\"Debug List breakpoints\")" }),
        },
        cmd = { 'Telescope' },
        dependencies = {
            require('plugins.plenary').spec,
            require('plugins.codicons').spec,

            -- Telescope plugins
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-dap.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = 'cmd /C "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"',
            },
        },
    },
}
