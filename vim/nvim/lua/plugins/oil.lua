local keymap = require("utils.keymap")

local open_buffer = function ()
    local buf_parent = vim.fn.expand("%:p:h")

    if #buf_parent > 0 then
        require("oil").open_float(buf_parent)
        return true
    end

    return false
end

local open_cwd = function ()
    local cwd = vim.fn.getcwd()

    if #cwd > 0 then
        require("oil").open_float(cwd)
        return true
    end

    return false
end

---@type PluginModule
return {
    spec = {
        "stevearc/oil.nvim",
        lazy = true,
        config = function ()
            require("oil").setup({
                -- Constrain the cursor to the file names
                constrain_cursor = "name",

                keymaps = {
                    ["-"] = "actions.open_cwd",
                    ["<BS>"] = "actions.parent",

                    ["q"] = "actions.close",

                    ["gs"] = false,
                    ["s"] = "actions.change_sort",
                },

                view_options = {
                    show_hidden = true,
                },

                float = {
                    padding = 2,
                    max_width = 80,
                    win_options = {
                        winblend = 10,
                    },
                },
            })

            vim.api.nvim_create_user_command("OilBuffer", open_buffer , { desc = "Opens oil.nvim in the parent directory of the current buffer" })
            vim.api.nvim_create_user_command("OilCwd", open_cwd , { desc = "Opens oil.nvim in the current working directory" })
            vim.api.nvim_create_user_command("Oil", function ()
                if not open_buffer() then
                    open_cwd()
                end
            end , { desc = "Opens oil.nvim in the parent directory of the current buffer. If that fails, then it opens in the current working directory" })
        end,
        keys = {
            keymap.normal.lazy("fo", open_buffer, { desc = "Open oil (buffer)" }),
            keymap.normal.lazy("fO", open_cwd, { desc = "Open oil (cwd)" }),
        },
        cmd = {
            "Oil",
        },
        dependencies = {
            require("plugins.nvim-web-devicons").spec,
            require("plugins.plenary").spec,
        }
    }
}
