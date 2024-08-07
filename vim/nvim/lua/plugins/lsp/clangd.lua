local default = require("plugins.lsp.default")

---@type LSP
return {
    setup_handler = default.setup_lsp({
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

            function (client, bufnr)
                vim.keymap.set("n", "<Leader>gs",  function ()
                    vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", { uri = vim.uri_from_bufnr(bufnr) }, function (err, targetFileUri, _)
                        if err ~= nil then
                            error(err)
                            return
                        end

                        if targetFileUri == nil or #targetFileUri == 0 then
                            print("Cannot determine corresponding file")
                            return
                        end

                        vim.api.nvim_command("edit " .. vim.uri_to_fname(targetFileUri))
                    end)
                end, { desc = "Switch between source and header", buffer = bufnr })
            end,
        },
        handlers = {
            default.handlers.display_messages_with_notify,
            default.handlers.underline_and_virtual_text_for_errors,
            default.handlers.hover,
            default.handlers.signature_help,
        },
    })
}
