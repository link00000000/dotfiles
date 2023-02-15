local M = {}

local function config ()
    local todo_comments = require('todo-comments')

    todo_comments.setup({
        keywords = {
            FIX = {
                alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'DELETE', 'DELETEME' }
            }
        },
        highlight = {
            pattern = [[.*<(KEYWORDS)\s*]],
        }
    })
end

M.spec = {
    'folke/todo-comments.nvim',
    lazy = false,
    config = config,
}

return M
