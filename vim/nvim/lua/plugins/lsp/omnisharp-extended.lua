local default_lsp = require("plugins.lsp.default")

---@type LSP
return {
    setup_handler = default_lsp.setup_lsp({
        on_attach = {
            default_lsp.on_attach.setup_keymap.code_action,
            default_lsp.on_attach.setup_keymap.rename,
            default_lsp.on_attach.setup_keymap.hover,
            default_lsp.on_attach.setup_keymap.error_hover,
            default_lsp.on_attach.setup_keymap.error_next,
            default_lsp.on_attach.setup_keymap.error_previous,
            function (client, bufnr)
                local telescope_theme = require("plugins.telescope").themes.dropdown({ bufnr = bufnr })
                require("omnisharp_extended").telescope_lsp_definitions(telescope_theme) ---@diagnostic disable-line
            end,
            default_lsp.on_attach.setup_keymap.goto_references,
            default_lsp.on_attach.setup_keymap.goto_implementation,
            default_lsp.on_attach.setup_keymap.goto_type_definition,

            default_lsp.on_attach.disable_lsp_provided_syntax_highlighting,

            default_lsp.on_attach.setup_document_highlight_on_cursor_hold,
            default_lsp.on_attach.setup_navic,
            default_lsp.on_attach.setup_folding,
        },
        handlers = {
            default_lsp.handlers.display_messages_with_notify,
            default_lsp.handlers.underline_and_virtual_text_for_errors,
            default_lsp.handlers.hover,
            default_lsp.handlers.signature_help,
        },
        flags = {
            debounce_text_changes = 150,
        }
    })
}
