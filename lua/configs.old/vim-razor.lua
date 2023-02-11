-- Set filetype to razor when file ends in .cshtml to that adamclerk/vim-razor will provide syntax highlighting
vim.api.nvim_command([[
    autocmd BufNewFile,BufRead *.cshtml set ft=razor
]])
