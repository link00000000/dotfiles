local generic_lsp_config = require("plugins.lsp.generic")

local M = {}

M.on_attach = function (client, bufnr)
    generic_lsp_config.on_attach(client, bufnr)
end

M.get_capabilities = function ()
    return generic_lsp_config.get_capabilities()
end

M.setup_handler = function ()
    local lspconfig = require("lspconfig")

    lspconfig.grammarly.setup({
        filetypes = { "txt", "md", "wiki", "vimwiki" },
        on_attach = M.on_attach,
        capabilities = M.get_capabilities(),
        settings = {
            grammarly = {
                config = {
                    suggestionCategories = {
                        oxfordComma = "on",
                    }
                },
                startTextCheckInPausedState = true,
            }
        }
    })
end

return M
