local autocmd = require("utils.autocmd")
local keymap = require("utils.keymap")

local M = {}

local function setup_current_line_blame ()
    autocmd.create_group("gitsigns", {
        { event = "InsertEnter", action = function () require("gitsigns").toggle_current_line_blame(false) end },
        { event = "InsertLeave", action = function () require("gitsigns").toggle_current_line_blame(true) end },
    })
end

local function config ()
    local gitsigns = require("gitsigns")

    gitsigns.setup({
        current_line_blame = true,
        current_line_blame_opts = {
            deplay = 70,
            virt_text_pos = "eol"
        }
    })

    setup_current_line_blame()

    require("plugins.which-key").add_group_label("<leader>g", "Git")
end

M.reset_hunk = function ()
    require("gitsigns").reset_hunk()
end

M.spec = {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = config,
    keys = {
        keymap.normal.lazy("<leader>gu", M.reset_hunk, { desc = "Reset hunk" })
    },
    dependencies = {
        require("plugins.which-key").spec,
    }
}

return M
