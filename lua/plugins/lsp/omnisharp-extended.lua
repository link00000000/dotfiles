local keymap = require('utils.keymap')
local generic_lsp_config = require('plugins.lsp.generic')

local M = {}

local function config ()
end

local function goto_definition ()
    local omnisharp_extended_lsp = require('omnisharp_extended')
    local telescope = require('plugins.telescope')

    omnisharp_extended_lsp.telescope_lsp_definitions(telescope.themes.dropdown({ bufnr = bufnr }))
end

M.setup_keymaps = function (bufnr)
    generic_lsp_config.setup_keymaps(bufnr)

    keymap.delete('<Leader>gd', { buffer = bufnr })

    keymap.normal.apply('<Leader>gd', goto_definition)
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
