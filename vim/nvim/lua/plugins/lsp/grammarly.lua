local default = require("plugins.lsp.default")

---@type LSP
return {
    setup_handler = default.create_setup_handler({
        on_attach = {
            default.on_attach.setup_keymap.code_action,
            default.on_attach.setup_keymap.rename,
            default.on_attach.setup_keymap.hover,
            default.on_attach.setup_keymap.error_hover,
            default.on_attach.setup_keymap.error_next,
            default.on_attach.setup_keymap.error_previous,
            default.on_attach.setup_keymap.goto_definition,
            default.on_attach.setup_keymap.goto_references,
            default.on_attach.setup_keymap.goto_implementation,
            default.on_attach.setup_keymap.goto_type_definition,

            default.on_attach.setup_document_highlight_on_cursor_hold,
            default.on_attach.setup_navic,
            default.on_attach.setup_folding,
        },
        handlers = {
            default.handlers.display_messages_with_notify,
            default.handlers.underline_and_virtual_text_for_errors,
        },
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
}
