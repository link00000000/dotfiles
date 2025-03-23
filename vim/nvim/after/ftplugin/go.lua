vim.api.nvim_create_augroup("GoFmtOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = "GoFmtOnSave",
    pattern = { "*.go" },
    callback = function ()
        vim.lsp.buf.format({ filter = function (client) return client.name == "gopls" end })
    end,
})

