local generic_lsp_config = require("plugins.lsp.generic")

local M = {}

M.setup_keymaps = function (bufnr)
    generic_lsp_config.setup_keymaps(bufnr)
end

M.on_attach = function (client, bufnr)
    generic_lsp_config.on_attach(client, bufnr)

    M.setup_keymaps(bufnr)
end

M.get_capabilities = function ()
    return generic_lsp_config.get_capabilities()
end

M.setup_handler = function ()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace"
                }
            }
        },
        on_attach = M.on_attach,
        capabilities = M.get_capabilities()
    })
end

return M
