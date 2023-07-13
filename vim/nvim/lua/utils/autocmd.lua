local func = require('utils.func')

local M = {}

local merge_create_group_default_opts = func.create_merge_default_opts({ clear = false })

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

M.create_command = function (event, action, opts)
    local merge_default_opts = func.create_merge_default_opts({ callback = action })
    opts = merge_default_opts(opts)

    vim.api.nvim_create_autocmd(event, opts)
end

return M
