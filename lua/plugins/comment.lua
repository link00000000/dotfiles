local keymap = require("utils.keymap")

local M = {}

local function config ()
    local comment = require("Comment")

    comment.setup({
        mappings = false
    })
end

M.toggle_line = function ()
    local comment_api = require("Comment.api")

    comment_api.toggle.linewise.current()
end

M.toggle_selection = function ()
    local comment_api = require("Comment.api")
    
    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(esc, "nx", false)

    comment_api.toggle.linewise(vim.fn.visualmode())
end

M.spec = {
    "numToStr/Comment.nvim",
    lazy = true,
    config = config,
    keys = {
        keymap.normal.lazy("<leader>/", M.toggle_line, { desc = 'Toggle comment on current line' }),
        keymap.visual_only.lazy("<leader>/", M.toggle_selection, { desc = 'Toggle comments on selected lines' }),
    }
}

return M
