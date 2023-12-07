local func = require('utils.func')

local M = {}

local merge_create_group_default_opts = func.create_merge_default_opts({ clear = false })

---@param group_name string
---@param commands { event: string|string[], action: function|string, opts: table }[]
---@param opts table?
M.create_group = function (group_name, commands, opts)
    commands = commands or {}
    opts = merge_create_group_default_opts(opts)

    vim.api.nvim_create_augroup(group_name, opts)

    for _, command in ipairs(commands) do
        local merge_command_default_opts = func.create_merge_default_opts({ group = group_name })
        local command_opts = merge_command_default_opts(command.opts)

        M.create_command(command.event, command.action, command_opts)
    end
end

---@param event string|string[]
---@param action function|string
---@param opts table
M.create_command = function (event, action, opts)
    local merge_default_opts = func.create_merge_default_opts({ callback = action })
    opts = merge_default_opts(opts)

    vim.api.nvim_create_autocmd(event, opts)
end

return M
