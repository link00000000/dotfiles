-- Open help pages in vertical split
local augroup = vim.api.nvim_create_augroup("VerticalHelpPages", {})
vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    pattern = "*.txt",
    command = "if &buftype == 'help' | wincmd L | endif"
})
