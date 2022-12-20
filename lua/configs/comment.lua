local comment = require('Comment')

comment.setup({
    --LHS of toggle mappings in NORMAL mode
    toggler = {
        line = '<Space>/',
        block = '<NOP>',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        line = '<Space>/',
        block = '<NOP>',
    },
    mappings = {
        basic = true,
        extra = false,
    },
})
