local buffertag = require('buffertag')

buffertag.setup({
    -- accepts any value that can be used in vim.api.nvim_open_win border option
    -- value.
    border = "single",
    limit_width = true
})
