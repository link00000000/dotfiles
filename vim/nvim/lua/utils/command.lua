local func = require('utils.func')

local M = {}

local merge_default_opts = func.create_merge_default_opts({ bang = true })

M.create = function (name, action, opts)
    opts = merge_default_opts(opts)
    vim.api.nvim_create_user_command(name, action, opts)
end

return M
