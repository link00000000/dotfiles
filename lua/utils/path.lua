local func = require('utils.func')

local M = {}

local merge_default_opts = func.create_merge_default_opts({ escape = false })

function M.escape (path)
    local escaped_path = path:gsub('\\', '/')

    return escaped_path
end

function M.nvim_config_dir (opts)
    opts = merge_default_opts(opts)

    local path = vim.fn.stdpath('config')

    if opts.escape then
        path = M.escape(path)
    end

    return path
end

function M.nvim_data_dir (opts)
    opts = merge_default_opts(opts)

    local path = vim.fn.stdpath('data')

    if opts.escape then
        path = M.escape(path)
    end

    return path
end

function M.get_nvim_config_dir (path, opts)
    opts = merge_default_opts(opts)

    local joined_path = M.nvim_config_dir() .. "/" .. path

    if opts.escape then
        joined_path = M.escape(joined_path)
    end

    return joined_path
end

function M.get_nvim_data_dir (path, opts)
    opts = merge_default_opts(opts)

    local joined_path = M.nvim_data_dir() .. "/" .. path

    if opts.escape then
        joined_path = M.escape(joined_path)
    end

    return joined_path
end

return M
