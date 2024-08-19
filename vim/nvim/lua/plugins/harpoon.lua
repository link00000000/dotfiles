local keymap = require("utils.keymap")

---@class HarpoonItem
---@field value string
---@field context any

---@class HarpoonList
---@field config any
---@field name string
---@field _length number
---@field _index number
---@field items HarpoonItem[]

---@class HarpoonBookmarkItem : HarpoonItem
---@field context { absolute_file_path: string, line_number: integer }

---@class HarpoonBookmarkList : HarpoonList
---@field items HarpoonBookmarkItem[]

---@param list HarpoonBookmarkList
local function toggle_bookmark_list_picker (list)
    local file_paths = {}
    for _, item in ipairs(list.items) do
        table.insert(file_paths, item.context.absolute_file_path)
    end

    local telescope_config = require("telescope.config")
    local telescope_pickers = require("telescope.pickers")
    local telescope_finders = require("telescope.finders")

    telescope_pickers.new({}, {
        prompt_title = "Bookmarks",
        finder = telescope_finders.new_table({ results = file_paths }),
        previewer = telescope_config.values.file_previewer({}),
        sorter = telescope_config.values.generic_sorter({}),
    }):find()
end

---@param list HarpoonList
local function toggle_marker (list)
    local new_item = list.config.create_list_item(list.config)

    local _, index = list:get_by_value(new_item)
    if index == -1 then
        list:add()
    else
        list:remove_at(index)
    end
end

---@type PluginModule
return {
    spec = {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            require("plugins.plenary").spec,
            require("plugins.telescope").spec,
        },
        config = function ()
            local harpoon = require("harpoon")

            harpoon:setup({
                ["bookmarks"] = {
                    ---@return HarpoonBookmarkItem
                    create_list_item = function ()
                        local line_number = vim.fn.line(".")
                        local absolute_file_path = vim.api.nvim_buf_get_name(0)

                        return {
                            value = absolute_file_path .. ":" .. line_number,
                            context = { line_number = line_number, absolute_file_path = absolute_file_path },
                        }
                    end,

                    ---@param item HarpoonBookmarkItem
                    ---@param list HarpoonBookmarkList
                    select = function (item, list)
                        vim.api.nvim_command("edit " .. item.context.absolute_file_path)
                        vim.api.nvim_win_set_cursor(0, { item.context.line_number - 1, 0 })
                    end,

                    ---@param item HarpoonBookmarkItem
                    ---@return string
                    encode = function (item)
                        return vim.json.encode(item.context) --[[@as string]]
                    end,

                    ---@param encoded_object string
                    ---@return HarpoonBookmarkItem
                    decode = function (encoded_object)
                        return vim.json.decode(encoded_object) --[[@as HarpoonBookmarkItem]]
                    end,

                    ---@param item HarpoonBookmarkItem
                    ---@return string
                    display = function (item)
                        local path = require("plenary.path")

                        local file_path = path:new(item.context.absolute_file_path)
                        file_path:make_relative(vim.fn.getcwd())

                        local file_path_display = file_path:shorten(3)

                        return file_path_display .. ":" .. item.context.line_number
                    end,

                    ---@param a HarpoonBookmarkItem
                    ---@param b HarpoonBookmarkItem
                    equals = function (a, b)
                        return a.context.line_number == a.context.line_number
                            and b.context.absolute_file_path == b.context.absolute_file_path
                    end
                }
            })
        end,
        keys = {
            keymap.normal.lazy("<Leader>ba", function () require("harpoon"):list("bookmarks"):add() end),
            keymap.normal.lazy("<Leader>bd", function () require("harpoon"):list("bookmarks"):remove() end),
            keymap.normal.lazy("<Leader>bt", function () toggle_marker(require("harpoon"):list("bookmarks")) end),

            keymap.normal.lazy("<Leader>bn", function () require("harpoon"):list("bookmarks"):next() end),
            keymap.normal.lazy("<Leader>bp", function () require("harpoon"):list("bookmarks"):prev() end),

            keymap.normal.lazy("<Leader>bb", function () toggle_bookmark_list_picker(require("harpoon"):list("bookmarks")) end)
        },
    },
}
