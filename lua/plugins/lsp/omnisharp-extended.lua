local keymap = require('utils.keymap')
local generic_lsp_config = require('plugins.lsp.generic')

local M = {}

local function config ()
end

local function show_definitions ()
    local omnisharp_extended_lsp = require('omnisharp_extended')

    -- TODO: Apply telescope theme
    omnisharp_extended_lsp.telescope_lsp_definitions()
end

M.setup_keymaps = function (bufnr)
    generic_lsp_config.setup_keymaps(bufnr)

    keymap.normal.apply('<Leader>gd', show_definitions)
end

M.on_attach = function (client, bufnr)
    generic_lsp_config.on_attach(client, bufnr)

    M.setup_keymaps(bufnr)
end

M.get_capabilities = function ()
    return generic_lsp_config.get_capabilities()
end

M.setup_handler = function ()
    local lspconfig = require('lspconfig')
    local omnisharp_extended_lsp = require('omnisharp_extended')

    lspconfig.omnisharp.setup({
        on_attach = M.on_attach,
        capabilities = M.get_capabilities(),
        flags = {
            debounce_text_changes = 150,
        },
        handlers = {
            ['textDocument/definition'] = omnisharp_extended_lsp.handler,
        },
    })
end

return M
