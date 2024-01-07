local func = require('utils.func')
local os_utils = require('utils.os');

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

function M.home ()
    local os_name = os_utils.get_os()
    local home_path = ""

    if os_name == os_utils.OS.windows then
        local win_home_path = os.getenv("USERPROFILE");
        if win_home_path == nil then
            error("Unable to get USERPROFILE environment variable")
        end

        home_path = win_home_path
    end

    return M.escape(home_path);
end

M.sync = {
    get_path = function ()
        return M.home() .. "/Sync"
    end,
    documents = {
        get_path = function ()
            return M.sync.get_path() .. "/Documents"
        end,
        vimwiki = {
            get_path = function ()
                return M.sync.documents.get_path() .. "/vimwiki"
            end,
        },
    },
    configs = {
        get_path = function ()
            return M.sync.get_path() .. "/Configs"
        end,
    },
}

return M
