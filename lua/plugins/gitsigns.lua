local autocmd = require("utils.autocmd")
local keymap = require("utils.keymap")

local M = {}

local function setup_current_line_blame ()
    autocmd.create_group("gitsigns", {
        { event = "InsertEnter", action = ":Gitsigns toggle_current_line_blame", opts = { pattern = { "*" } } },
        { event = "InsertLeave", action = ":Gitsigns toggle_current_line_blame", opts = { pattern = { "*" } } }
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
end

M.reset_hunk = function ()
    local gitsigns = require("gitsigns")

    gitsigns.reset_hunk()
end

M.spec = {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    config = config,
    keys = {
        keymap.normal.lazy("<leader>gu", M.reset_hunk, { desc = "Reset hunk" })
    }
}

return M
