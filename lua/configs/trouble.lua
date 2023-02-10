local trouble = require('trouble')

trouble.setup({
    action_keys = {
        hover = "<Leader>k",
        close_folds = "<S-h>",
        open_folds = "<S-l>",
        toggle_fold = { "h", "l" }
    }
})

local opts = { silent = true, noremap = true }
vim.keymap.set("n", "<Leader>ee", "<cmd>TroubleToggle<CR>", opts)
