local dap_type_to_ft = {
    go = "go"
}

---@type PluginModule
return
{
    spec = {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function ()
            local codicons = require("codicons")
            local dap = require("dap")

            vim.fn.sign_define("DapBreakpoint", {
                text = codicons.get("circle-filled", "icon"),
                texthl = "Error",
            })

            vim.fn.sign_define("DapBreakpointCondition", {
                text = codicons.get("debug-breakpoint-conditional", "icon"),
                texthl = "Error",
            })

            vim.fn.sign_define("DapLogPoint", {
                text = codicons.get("debug-breakpoint-log", "icon"),
                texthl = "Error",
            })

            vim.fn.sign_define("DapStopped", {
                text = codicons.get("arrow-right", "icon"),
                texthl = "WarningMsg",
                linehl = "Search",
            })

            vim.fn.sign_define("DapRejected", {
                text = codicons.get("circle-filled", "icon"),
                texthl = "BufferOffset",
            })

            vim.keymap.set("n", "<Leader>dr", function ()
                local repl_bufnr = require("dap.repl").open()
                local repl_winnr = nil

                for _, winnr in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_buf(winnr) == repl_bufnr then
                        repl_winnr = winnr
                        break
                    end
                end

                if repl_winnr ~= nil then
                    vim.api.nvim_set_current_win(repl_winnr)
                    vim.cmd.startinsert()
                end
            end)

            ---@type { bufnr: integer|nil, winnr: integer|nil, cmdnr: integer|nil }|nil
            local hover_floating_win = nil

            vim.keymap.set("n", "<Leader>dk", function ()
                local dap_session = dap.session()
                if dap_session == nil then
                    return
                end

                local hovered_node = vim.treesitter.get_node()
                if hovered_node == nil then
                    return
                end

                if hovered_node:type() ~= "identifier" then
                    -- Only identifiers should be evaluated
                    return
                end

                local function delete_floating_win ()
                    if hover_floating_win ~= nil and hover_floating_win.bufnr ~= nil then
                        vim.api.nvim_buf_delete(hover_floating_win.bufnr, { force = true })
                    end

                    hover_floating_win = nil
                end

                ---@param text string
                ---@param filetype string|nil
                local function create_floating_win (text, filetype)
                    hover_floating_win = {}

                    hover_floating_win.bufnr = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_text(hover_floating_win.bufnr, 0, 0, -1, 0, { text })

                    hover_floating_win.winnr = vim.api.nvim_open_win(hover_floating_win.bufnr, false, {
                        relative = "cursor",
                        style = "minimal",
                        border = "rounded",
                        anchor = "SW",
                        row = 0,
                        col = 0,
                        width = math.min(120, #text),
                        height = 1,
                    })
                    vim.bo[hover_floating_win.bufnr].ft = filetype

                    cmdnr = vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                        buffer = 0,
                        callback = delete_floating_win
                    })

                    vim.keymap.set("n", "q", delete_floating_win, { desc = "Close floating window" })
                    vim.keymap.set("n", "<Esc>", delete_floating_win, { desc = "Close floating window" })
                    vim.keymap.set("n", "<C-c>", delete_floating_win, { desc = "Close floating window" })
                end

                if hover_floating_win == nil then
                    local dap_session = dap.session()
                    if dap_session == nil then
                        return
                    end

                    dap_session:request("evaluate", {
                        expression = vim.treesitter.get_node_text(hovered_node, 0)
                    }, function (err, result)
                        if err ~= nil then
                            local error_message = err.message
                            if err.body ~= nil and err.body.format ~= nil then
                                error_message = err.body.format
                            end

                            vim.notify(error_message, vim.log.levels.ERROR)
                            return
                        end

                        create_floating_win(result.result, dap_type_to_ft[dap_session.config.type])
                    end)

                else
                    vim.api.nvim_set_current_win(hover_floating_win.winnr)
                end
            end, { desc = "Show current value of variable under cursor" })
        end,
        dependencies = {
            require("plugins.codicons").spec,
        },
    },
}
