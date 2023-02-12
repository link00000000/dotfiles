local M = {}

local function merge_default_opts (opts)
    opts = opts or {}
    local default_opts = { bang = true }

    return vim.tbl_deep_extend("force", default_opts, opts)
end

M.create = function (name, action, opts)
    opts = merge_default_opts(opts)
    vim.api.nvim_create_user_command(name, action, opts)
end

return M
