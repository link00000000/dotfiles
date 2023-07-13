local keymap = require("utils.keymap")

local M = {}

local function config ()
    local trouble = require("trouble")

    trouble.setup({
        action_keys = {
            hover = "<Leader>k",
            close_folds = "<S-h>",
            open_folds = "<S-l>",
            toggle_fold = { "h", "l" }
        }
    })
end

M.toggle_window = function ()
    local trouble = require("trouble")

    trouble.toggle()
end

M.next_error = function ()
    local trouble = require("trouble")

    trouble.next()
end

M.prev_error = function ()
    local trouble = require("trouble")

    trouble.previous()
end

M.spec = {
    "folke/trouble.nvim",
    lazy = true,
    config = config,
    keys = {
        keymap.normal.lazy("<leader>ee", M.toggle_window),
        keymap.normal.lazy("<leader>en", M.next_error),
        keymap.normal.lazy("<leader>ep", M.prev_error)
    },
    event = "VimEnter",
    cmd = { "Trouble"}
}

return M
