local keymap = require('utils.keymap')

local M = {}

local function setup_document_highlight (client)
    -- TODO: Use Lua instead of vimscript
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
end

-- TODO: Setup missing function in old mason-lspconfig
-- local function diagnostic_open_float(client) -- this one

M.setup_keymaps = function (bufnr)
    keymap.normal.apply('<Leader>a',    vim.lsp.buf.code_action,        { buffer = bufnr })
    keymap.normal.apply('<F2>',         vim.lsp.buf.rename,             { buffer = bufnr })
    keymap.normal.apply('<Leader>k',    vim.lsp.buf.hover,              { buffer = bufnr })

    keymap.normal.apply('<Leader>ek',   vim.diagnostic.open_float,      { buffer = bufnr })
    keymap.normal.apply('<Leader>en',   vim.diagnostic.goto_next,       { buffer = bufnr })
    keymap.normal.apply('<Leader>ep',   vim.diagnostic.goto_prev,       { buffer = bufnr })

    --keymap.normal.apply('<Leader>o',    vim.)



    -- TODO: Setup keymaps
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
