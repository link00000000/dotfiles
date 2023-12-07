local keymap = require("utils.keymap")

local function config ()
    local comment = require("Comment")

    comment.setup({
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---Lines to be ignored while (un)comment
        ignore = nil, ---@diagnostic disable-line ignore does not allow nil when it is valid
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
            ---Line-comment toggle keymap
            line = 'gcc',
            ---Block-comment toggle keymap
            block = 'gbc',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            ---Line-comment keymap
            line = 'gc',
            ---Block-comment keymap
            block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
            ---Add comment on the line above
            above = 'gcO',
            ---Add comment on the line below
            below = 'gco',
            ---Add comment at the end of line
            eol = 'gcA',
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = false,
        ---Function to call before (un)comment
        pre_hook = nil, ---@diagnostic disable-line pre_hook does not allow nil when it is valid
        ---Function to call after (un)comment
        post_hook = nil, ---@diagnostic disable-line post_hook does not allow nil when it is valid
    })
end

local toggle_line = function ()
    local comment_api = require("Comment.api")

    comment_api.toggle.linewise.current()
end

local toggle_selection = function ()
    local comment_api = require("Comment.api")

    local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
    vim.api.nvim_feedkeys(esc, "nx", false)

    comment_api.toggle.linewise(vim.fn.visualmode())
end

---@type PluginModule
return {
    spec = {
        "numToStr/Comment.nvim",
        lazy = true,
        config = config,
        keys = {
            keymap.normal.lazy("<leader>/", toggle_line, { desc = 'Toggle comment on current line' }),
            keymap.visual_only.lazy("<leader>/", toggle_selection, { desc = 'Toggle comments on selected lines' }),
        }
    }
}
