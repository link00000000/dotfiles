local gitsigns = require('gitsigns')

gitsigns.setup({
    current_line_blame = true,
    current_line_blame_opts = {
        deplay = 70,
        virt_text_pos = 'eol'
    }
})

vim.api.nvim_exec([[
    augroup gitsigns
        autocmd!
        autocmd InsertEnter * :Gitsigns toggle_current_line_blame
        autocmd InsertLeave * :Gitsigns toggle_current_line_blame
    augroup END
]], true)

local opts = { silent = true }
vim.keymap.set({'n', 'v'}, '<leader>gu', ':Gitsigns reset_hunk<CR>', opts) -- Must start with :. If using <cmd>, it will not work with ranges
