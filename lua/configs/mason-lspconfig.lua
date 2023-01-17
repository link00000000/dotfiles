local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local telescope_builtin = require('telescope.builtin')
local telescope_themes = require('telescope.themes')
local omnisharp_extended_lsp = require('omnisharp_extended')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local folding = require('folding')

local wide_layout_config = { width =  0.9 }

mason_lspconfig.setup()

local function lsp_keymaps(bufnr)
    local opts = { silent = true }
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    buf_set_keymap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<Leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    buf_set_keymap('n', '<Leader>ek', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '<Leader>en', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<Leader>ep', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

    buf_set_keymap('n', '<C-S-o>', '', { silent = true, noremap = true, callback =
        function()
            telescope_builtin.lsp_document_symbols(telescope_themes.get_dropdown({ trim_text = true, layout_config = wide_layout_config }))
        end,
    })

    buf_set_keymap('n', '<Leader>gr', '', { silent = true, noremap = true, callback =
        function()
            telescope_builtin.lsp_references(telescope_themes.get_dropdown({
                include_declaration = false,
                include_current_line = true,
                trim_text = true,
                layout_config = wide_layout_config,
            }))
        end,
    })

    buf_set_keymap('n', '<Leader>gi', '', { silent = true, noremap = true, callback =
        function ()
            telescope_builtin.lsp_implementations(telescope_themes.get_dropdown({ trim_text = true, layout_config = wide_layout_config }))
        end
    })

    buf_set_keymap('n', '<Leader>gd', '', { silent = true, noremap = true, callback =
        function ()
            telescope_builtin.lsp_definitions(telescope_themes.get_dropdown({ trim_text = true, layout_config = wide_layout_config }))
        end,
    })

    buf_set_keymap('n', '<Leader>gt', '', { silent = true, noremap = true, callback =
        function ()
            telescope_builtin.lsp_type_definitions(telescope_themes.get_dropdown({ layout_config = wide_layout_config }))
        end,
    })

    buf_set_keymap('n', '<Leader>ee', '', { silent = true, noremap = true, callback =
        function ()
            telescope_builtin.diagnostics(telescope_themes.get_dropdown({ bufnr = 0, layout_config = wide_layout_config }))
        end,
    })
end

local function lsp_document_highlight(client)
    local capture_output = false

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], capture_output)
    end
end

local function diagnostic_open_float(client)
    local capture_output = false

    vim.api.nvim_exec([[
        augroup diagnostic_open_float
            autocmd CursorHold  <buffer> lua vim.diagnostic.open_float()
            autocmd CursorHoldI <buffer> lua vim.diagnostic.open_float()
        augroup END
    ]], capture_output)
end

-- Automatically setup LSP servers installed with mason.nvim
-- See :h mason-lspconfig-automatic-server-setup
mason_lspconfig.setup_handlers({
    function (server_name)
        lspconfig[server_name].setup({
            on_attach = function (client, bufnr)
                lsp_keymaps(bufnr)
                lsp_document_highlight(client)
                folding.on_attach()
            end,
            capabilities = cmp_nvim_lsp.default_capabilities(), -- Add additional capabilities supported by nvim-cmp
            flags = {
                debounce_text_changes = 150,
            },
        })
    end,
    ["omnisharp"] = function ()
        require("lspconfig").omnisharp.setup({
            on_attach = function (client, bufnr)
                lsp_keymaps(bufnr)
                lsp_document_highlight(client)
                folding.on_attach()

                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>gd', '', { silent = true, noremap = true, callback =
                    function ()
                        omnisharp_extended_lsp.telescope_lsp_definitions(telescope_themes.get_dropdown({ bufnr = bufnr }))
                    end,
                })
            end,
            capabilities = cmp_nvim_lsp.default_capabilities(), -- Add additional capabilities supported by nvim-cmp
            flags = {
                debounce_text_changes = 150,
            },
            handlers = {
                -- Correctly view decompiled sources when symbol definition is in an external assembly
                ["textDocument/definition"] = omnisharp_extended_lsp.handler,
            },
        })
    end
})

