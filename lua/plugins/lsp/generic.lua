local keymap = require('utils.keymap')
local autocmd = require('utils.autocmd')

local M = {}

local function setup_document_highlight (client)
    if client.server_capabilities.documentHighlightProvider then
        autocmd.create_group('lsp_document_highlight', {
            { event = 'CursorHold',  action = vim.lsp.buf.document_highlight },
            { event = 'CursorHoldI', action = vim.lsp.buf.document_highlight },
            { event = 'CursorMoved', action = vim.lsp.buf.clear_references   },
        }, { clear = true })
    end
end

local function goto_definition ()
    local telescope_builtin = require('telescope.builtin')
    local telescope = require('plugins.telescope')

    telescope_builtin.lsp_definitions(telescope.themes.dropdown({ trim_text = true }))
end

local function goto_references ()
    local telescope_builtin = require('telescope.builtin')
    local telescope = require('plugins.telescope')

    telescope_builtin.lsp_references(telescope.themes.dropdown({ trim_text = true, include_declaration = false, include_current_line = true }))
end

local function goto_implementations ()
    local telescope_builtin = require('telescope.builtin')
    local telescope = require('plugins.telescope')

    telescope_builtin.lsp_implementations(telescope.themes.dropdown({ trim_text = true }))
end

local function goto_type_definitions ()
    local telescope_builtin = require('telescope.builtin')
    local telescope = require('plugins.telescope')

    telescope_builtin.lsp_implementations(telescope.themes.dropdown({ trim_text = true }))
end

M.setup_keymaps = function (bufnr)
    keymap.normal.apply('<Leader>a',    vim.lsp.buf.code_action,        { buffer = bufnr })
    keymap.normal.apply('<F2>',         vim.lsp.buf.rename,             { buffer = bufnr })
    keymap.normal.apply('<Leader>k',    vim.lsp.buf.hover,              { buffer = bufnr })

    keymap.normal.apply('<Leader>ek',   vim.diagnostic.open_float,      { buffer = bufnr })
    keymap.normal.apply('<Leader>en',   vim.diagnostic.goto_next,       { buffer = bufnr })
    keymap.normal.apply('<Leader>ep',   vim.diagnostic.goto_prev,       { buffer = bufnr })

    keymap.normal.apply('<Leader>gd',   goto_definition,                { buffer = bufnr })
    keymap.normal.apply('<Leader>gr',   goto_references,                { buffer = bufnr })
    keymap.normal.apply('<Leader>gi',   goto_implementations,           { buffer = bufnr })
    keymap.normal.apply('<Leader>gt',   goto_type_definitions,          { buffer = bufnr })
end

M.on_attach = function (client, bufnr)
    M.setup_keymaps(bufnr)
    setup_document_highlight(client)

    require('plugins.folding').on_attach()
    require('plugins.navic').on_attach(client, bufnr)
end

M.get_capabilities = function ()
    local cmp_nvim_lsp = require('plugins.cmp-nvim-lsp')

    return cmp_nvim_lsp.get_default_capabilities()
end

M.setup_handler = function (server_name)
    local lspconfig = require('lspconfig')

    lspconfig[server_name].setup({
        on_attach = M.on_attach,
        capabilities = M.get_capabilities(),
    })
end

return M
