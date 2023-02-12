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

return {
    'folke/todo-comments.nvim',
    lazy = false,
    config = config,
}
