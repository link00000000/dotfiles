vim.api.nvim_create_augroup("GoFmtOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = "GoFmtOnSave",
    pattern = { "*.go" },
    callback = function()
        local gopls_attached = false
        for i, client in ipairs(vim.lsp.buf_get_clients()) do
          if client.name == "gopls" then
            gopls_attached = true 
            break
          end
        end

        if gopls_attached == false then
          return
        end

        vim.lsp.buf.format()
    end,
})

