local func = require('utils.func')

local M = {}

local merge_default_opts = func.create_merge_default_opts({ escape = false })

---@param path string
---@return string
function M.escape (path)
    local escaped_path = path:gsub('\\', '/')

    return escaped_path
end

---@param opts { escape: boolean? }?
function M.nvim_config_dir (opts)
    opts = merge_default_opts(opts)

    local path = vim.fn.stdpath('config')
    if (path == nil) then
        error("vim.fn.stdpath('config') returned nil")
    end

    if opts ~= nil and opts.escape then
        path = M.escape(path)
    end

    return path
end

---@param opts { escape: boolean? }?
function M.nvim_data_dir (opts)
    opts = merge_default_opts(opts)

    local path = vim.fn.stdpath('data')
    if (path == nil) then
        error("vim.fn.stdpath('config') returned nil")
    end

    if opts.escape then
        path = M.escape(path)
    end

    return path
end

---@param relative_path string
---@param opts { escape: boolean? }?
function M.resolve_nvim_config_dir_path (relative_path, opts)
    opts = merge_default_opts(opts)

    local joined_path = M.nvim_config_dir() .. "/" .. relative_path

    if opts.escape then
        joined_path = M.escape(joined_path)
    end

    return joined_path
end

---@param relative_path string
---@param opts { escape: boolean? }?
function M.resolve_nvim_data_dir_path (relative_path, opts)
    opts = merge_default_opts(opts)

    local joined_path = M.nvim_data_dir() .. "/" .. relative_path

    if opts.escape then
        joined_path = M.escape(joined_path)
    end

    return joined_path
end

return M
