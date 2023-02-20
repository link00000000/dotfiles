local M = {}

function M.create_merge_default_opts (default_opts)
    return function (opts)
        opts = opts or {}

        return vim.tbl_deep_extend("force", default_opts, opts)
    end
end

return M
