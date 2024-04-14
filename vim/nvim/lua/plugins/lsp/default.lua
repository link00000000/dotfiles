---@class LSP
---@field setup_handler fun(server_name: string)

---@alias lsp.OnAttach fun(client: any, bufnr: integer)
---@alias OnAttachConfig { [string]: lsp.OnAttach, setup_keymap: { [string]: lsp.OnAttach } }
---@type OnAttachConfig
local on_attach = {
    setup_keymap = {
        ---@type lsp.OnAttach
        code_action = function (client, bufnr)
            require("utils.keymap").normal.apply("<Leader>a", vim.lsp.buf.code_action, { buffer = bufnr })
        end,
        rename = function (client, bufnr)
            require("utils.keymap").normal.apply('<F2>', vim.lsp.buf.rename, { buffer = bufnr })
        end,
        hover = function (client, bufnr)
            require("utils.keymap").normal.apply('<Leader>k', vim.lsp.buf.hover, { buffer = bufnr })
        end,

        error_hover = function (client, bufnr)
            require("utils.keymap").normal.apply('<Leader>ek', vim.diagnostic.open_float, { buffer = bufnr })
        end,
        error_next = function (client, bufnr)
            require("utils.keymap").normal.apply('<Leader>en', vim.diagnostic.goto_next, { buffer = bufnr })
        end,
        error_previous = function (client, bufnr)
            require("utils.keymap").normal.apply('<Leader>ep', vim.diagnostic.goto_prev, { buffer = bufnr })
        end,

        goto_definition = function (client, bufnr)
            require("utils.keymap").normal.apply('<Leader>gd', function () vim.cmd("Glance definitions") end, { buffer = bufnr })
        end,
        goto_references = function (client, bufnr)
            require("utils.keymap").normal.apply('<Leader>gr', function () vim.cmd("Glance references") end, { buffer = bufnr })
        end,
        goto_implementation = function (client, bufnr)
            require("utils.keymap").normal.apply('<Leader>gi', function () vim.cmd("Glance implementations") end, { buffer = bufnr })
        end,
        goto_type_definition = function (client, bufnr)
            require("utils.keymap").normal.apply('<Leader>gt', function () vim.cmd("Glance type_definitions") end, { buffer = bufnr })
        end,
    },

    setup_document_highlight_on_cursor_hold = function (client, bufnr)
        if client.server_capabilities.documentHighlightProvider then
            local autocmd = require('utils.autocmd')

            autocmd.create_group('lsp_document_highlight', {
                { event = 'CursorHold',  action = vim.lsp.buf.document_highlight, opts = { buffer = bufnr } },
                { event = 'CursorHoldI', action = vim.lsp.buf.document_highlight, opts = { buffer = bufnr } },
                { event = 'CursorMoved', action = vim.lsp.buf.clear_references, opts = { buffer = bufnr } },
            }, { clear = true })
        end
    end,

    disable_cmp = function (client, bufnr)
        if client ~= nil and client.server_capabilities ~= nil then
            client.server_capabilities.completionProvider = false
        end
    end,

    disable_lsp_provided_syntax_highlighting = function (client, bufnr)
        if client ~= nil and client.server_capabilities ~= nil then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,

    setup_folding = require("plugins.folding").on_attach,
    setup_navic = require("plugins.navic").on_attach,
}

---@alias lsp.Capabilities any
---@return lsp.Capabilities
local function advertise_cmp_capabilities ()
    return require("cmp_nvim_lsp").default_capabilities()
end

---@class lsp.HandlerConfig
---@field message string
---@field handler lsp-handler

---@type { [string]: lsp.HandlerConfig }
local handlers = {
    display_messages_with_notify = {
        message = "window/showMessage",
        handler = function (err, result, context, config)
            local client = vim.lsp.get_client_by_id(context.client_id)
            local level = ({ "ERROR", "WARN", "INFO", "DEBUG" })[result.type]

            require("notify")(result.message, level, {
                title = "LSP | " .. client.name,
                timeout = 10000,
                keep = function ()
                    return level == "ERROR" or level == "WARN"
                end
            })
        end
    },

    underline_and_virtual_text_for_errors = {
        message = "textDocument/publishDiagnostics",
        handler = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            virtual_text = {
                spacing = 5,
                severity_limit = 'Warning',
            },
            update_in_insert = true,
        })
    },

    hover = {
        message = "textDocument/hover",
        handler = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })
    },

    signature_help = {
        message = "textDocument/signatureHelp",
        handler = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })
    },
}

---@class CreateSetupHandlerOpts
---@field on_attach lsp.OnAttach[]|nil
---@field handlers lsp.HandlerConfig[]|nil

---@param opts CreateSetupHandlerOpts
---@return lsp-handler
local function setup_lsp (opts)
    -- Convert { { "textDocument/showMessage", function () print("A") end }, { "textDocument/showMessage", function () print("B") end } }
    -- to { "textDocument/showMessage", function () print("A") print("B") end }
    local resolved_handlers = {}
    if opts.handlers then
        local handlers_by_message = {}

        for _, value in pairs(opts.handlers) do
            if handlers_by_message[value.message] == nil then
                handlers_by_message[value.message] = {}
            end

            table.insert(handlers_by_message[value.message], value.handler)
        end

        for message, handlers_for_message in pairs(handlers_by_message) do
            resolved_handlers[message] = function (err, result, context, config)
                for _, handler in pairs(handlers_for_message) do
                    handler(err, result, context, config)
                end
            end
        end
    end

    return function (server_name)
        local setup_config = vim.tbl_deep_extend("force", opts, {
            on_attach = function (client, bufnr)
                if opts.on_attach then
                    for _, value in pairs(opts.on_attach) do
                        value(client, bufnr)
                    end
                end
            end,
            handlers = resolved_handlers,
        })

        require("lspconfig")[server_name].setup(setup_config)
    end
end

---@type LSP
return {
    on_attach = on_attach,
    handlers = handlers,
    advertise_cmp_capabilities = advertise_cmp_capabilities,
    setup_lsp = setup_lsp,

    setup_handler = setup_lsp({
        on_attach = {
            on_attach.setup_keymap.code_action,
            on_attach.setup_keymap.rename,
            on_attach.setup_keymap.hover,
            on_attach.setup_keymap.error_hover,
            on_attach.setup_keymap.error_next,
            on_attach.setup_keymap.error_previous,
            on_attach.setup_keymap.goto_definition,
            on_attach.setup_keymap.goto_references,
            on_attach.setup_keymap.goto_implementation,
            on_attach.setup_keymap.goto_type_definition,

            on_attach.disable_lsp_provided_syntax_highlighting,

            on_attach.setup_document_highlight_on_cursor_hold,
            on_attach.setup_navic,
            on_attach.setup_folding,
        },
        handlers = {
            handlers.display_messages_with_notify,
            handlers.underline_and_virtual_text_for_errors,
            handlers.hover,
            handlers.signature_help,
        }
    })
}
