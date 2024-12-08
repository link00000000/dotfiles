---@alias lsp.OnAttach fun(client: any, bufnr: integer)
---@alias OnAttachConfig { [string]: lsp.OnAttach, setup_keymap: { [string]: lsp.OnAttach } }
---@type OnAttachConfig
local on_attach = {
  setup_keymap_code_action = function (client, bufnr)
    vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
  end,
  setup_keymap_rename = function (client, bufnr)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
  end,
  setup_keymap_hover = function (client, bufnr)
    vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show info" })
  end,
  setup_keymap_error_hover = function (client, bufnr)
    vim.keymap.set("n", "<Leader>ek", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostic" })
  end,
  setup_keymap_error_next = function (client, bufnr)
    vim.keymap.set("n", "<Leader>en", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Go to next diagnostic" })
  end,
  setup_keymap_error_previous = function (client, bufnr)
    vim.keymap.set("n", "<Leader>ep", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Go to previous diagnostic" })
  end,
  setup_keymap_goto_definition = function (client, bufnr)
    vim.keymap.set("n", "<Leader>gd", function () vim.cmd("Glance definitions") end, { buffer = bufnr, desc = "Go to definition" })
  end,
  setup_keymap_goto_references = function (client, bufnr)
    vim.keymap.set("n", "<Leader>gr", function () vim.cmd("Glance references") end, { buffer = bufnr, desc = "Go to references" })
  end,
  setup_keymap_goto_implementation = function (client, bufnr)
    vim.keymap.set("n", "<Leader>gi", function () vim.cmd("Glance implementations") end, { buffer = bufnr, desc = "Go to implementation" })
  end,
  setup_keymap_goto_type_definition = function (client, bufnr)
    vim.keymap.set("n", "<Leader>gt", function () vim.cmd("Glance type_definitions") end, { buffer = bufnr, desc = "Go to type definition" })
  end,

  setup_symbol_highlight_on_cursor_hold = function (client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
      local group_id = vim.api.nvim_create_augroup("lsp_document_highlight", {})
      vim.api.nvim_create_autocmd("CursorHold", { callback = vim.lsp.buf.document_highlight, buffer = bufnr, group = group_id })
      vim.api.nvim_create_autocmd("CursorHoldI", { callback = vim.lsp.buf.document_highlight, buffer = bufnr, group = group_id })
      vim.api.nvim_create_autocmd("CursorMoved", { callback = vim.lsp.buf.clear_references, buffer = bufnr, group = group_id })
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

  --setup_folding = require("plugins.folding").on_attach,
  --setup_navic = require("plugins.navic").on_attach,
}

---@type { [string]: lsp.HandlerConfig }
local handlers = {
    underline_and_virtual_text_for_errors = {
        message = "textDocument/publishDiagnostics",
        handler = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            virtual_text = {
                spacing = 5,
                severity = { min = vim.diagnostic.severity.HINT, },
            },
            update_in_insert = true,
        })
    },

    hover = {
        message = "textDocument/hover",
        handler = vim.lsp.with(vim.lsp.handlers.hover, {
            border = require("config/style").border,
        })
    },

    signature_help = {
        message = "textDocument/signatureHelp",
        handler = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = require("config/style").border,
        })
    },
}

---@alias lsp.Capabilities any
---@return lsp.Capabilities
local function advertise_cmp_capabilities ()
  return require("cmp_nvim_lsp").default_capabilities()
end

---@param server_name LSP server name
---@param opts CreateSetupHandlerOpts
---@return lsp-handler
local function setup_lsp (server_name, opts)
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

return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    setup_lsp("clangd", {
      on_attach = {
        on_attach.setup_keymap_code_action,
        on_attach.setup_keymap_rename,
        on_attach.setup_keymap_hover,
        on_attach.setup_keymap_error_hover,
        on_attach.setup_keymap_error_next,
        on_attach.setup_keymap_error_previous,
        on_attach.setup_keymap_goto_definition,
        on_attach.setup_keymap_goto_references,
        on_attach.setup_keymap_goto_implementation,
        on_attach.setup_keymap_goto_type_definition,

        on_attach.setup_symbol_highlight_on_cursor_hold,

        function (client, bufnr)
          vim.keymap.set("n", "<Leader>gs", ":ClangdSwitchSourceHeader<CR>", { buffer = bufnr, silent = true, desc = "Show info" })
        end
      },
      handlers = {
        handlers.underline_and_virtual_text_for_errors,
        handlers.hover,
        handlers.signature_help,
      },
    })

    setup_lsp("gopls", {
      on_attach = {
        on_attach.setup_keymap_code_action,
        on_attach.setup_keymap_rename,
        on_attach.setup_keymap_hover,
        on_attach.setup_keymap_error_hover,
        on_attach.setup_keymap_error_next,
        on_attach.setup_keymap_error_previous,
        on_attach.setup_keymap_goto_definition,
        on_attach.setup_keymap_goto_references,
        on_attach.setup_keymap_goto_implementation,
        on_attach.setup_keymap_goto_type_definition,

        on_attach.setup_symbol_highlight_on_cursor_hold,
      },
      handlers = {
        handlers.underline_and_virtual_text_for_errors,
        handlers.hover,
        handlers.signature_help,
      },
    })

    setup_lsp("nil_ls", {
      on_attach = {
        on_attach.setup_keymap_code_action,
        on_attach.setup_keymap_rename,
        on_attach.setup_keymap_hover,
        on_attach.setup_keymap_error_hover,
        on_attach.setup_keymap_error_next,
        on_attach.setup_keymap_error_previous,
        on_attach.setup_keymap_goto_definition,
        on_attach.setup_keymap_goto_references,
        on_attach.setup_keymap_goto_implementation,
        on_attach.setup_keymap_goto_type_definition,

        on_attach.setup_symbol_highlight_on_cursor_hold,
      },
      handlers = {
        handlers.underline_and_virtual_text_for_errors,
        handlers.hover,
        handlers.signature_help,
      },
    })

    setup_lsp("html", {
      on_attach = {
        on_attach.setup_keymap_code_action,
        on_attach.setup_keymap_rename,
        on_attach.setup_keymap_hover,
        on_attach.setup_keymap_error_hover,
        on_attach.setup_keymap_error_next,
        on_attach.setup_keymap_error_previous,
        on_attach.setup_keymap_goto_definition,
        on_attach.setup_keymap_goto_references,
        on_attach.setup_keymap_goto_implementation,
        on_attach.setup_keymap_goto_type_definition,

        on_attach.setup_symbol_highlight_on_cursor_hold,
      },
      handlers = {
        handlers.underline_and_virtual_text_for_errors,
        handlers.hover,
        handlers.signature_help,
      },
    })

    setup_lsp("cssls", {
      on_attach = {
        on_attach.setup_keymap_code_action,
        on_attach.setup_keymap_rename,
        on_attach.setup_keymap_hover,
        on_attach.setup_keymap_error_hover,
        on_attach.setup_keymap_error_next,
        on_attach.setup_keymap_error_previous,
        on_attach.setup_keymap_goto_definition,
        on_attach.setup_keymap_goto_references,
        on_attach.setup_keymap_goto_implementation,
        on_attach.setup_keymap_goto_type_definition,

        on_attach.setup_symbol_highlight_on_cursor_hold,
      },
      handlers = {
        handlers.underline_and_virtual_text_for_errors,
        handlers.hover,
        handlers.signature_help,
      },
    })

    setup_lsp("eslint", {
      on_attach = {
        on_attach.setup_keymap_code_action,
        on_attach.setup_keymap_rename,
        on_attach.setup_keymap_hover,
        on_attach.setup_keymap_error_hover,
        on_attach.setup_keymap_error_next,
        on_attach.setup_keymap_error_previous,
        on_attach.setup_keymap_goto_definition,
        on_attach.setup_keymap_goto_references,
        on_attach.setup_keymap_goto_implementation,
        on_attach.setup_keymap_goto_type_definition,

        on_attach.setup_symbol_highlight_on_cursor_hold,
      },
      handlers = {
        handlers.underline_and_virtual_text_for_errors,
        handlers.hover,
        handlers.signature_help,
      },
    })

    setup_lsp("ts_ls", {
      on_attach = {
        on_attach.setup_keymap_code_action,
        on_attach.setup_keymap_rename,
        on_attach.setup_keymap_hover,
        on_attach.setup_keymap_error_hover,
        on_attach.setup_keymap_error_next,
        on_attach.setup_keymap_error_previous,
        on_attach.setup_keymap_goto_definition,
        on_attach.setup_keymap_goto_references,
        on_attach.setup_keymap_goto_implementation,
        on_attach.setup_keymap_goto_type_definition,

        on_attach.setup_symbol_highlight_on_cursor_hold,
      },
      handlers = {
        handlers.underline_and_virtual_text_for_errors,
        handlers.hover,
        handlers.signature_help,
      },
    })
  end
}
