local M = {}

---@param default_opts table
---@return function
function M.create_merge_default_opts (default_opts)
    return function (opts)
        opts = opts or {}

        return vim.tbl_deep_extend("force", default_opts, opts)
    end
end

return M
