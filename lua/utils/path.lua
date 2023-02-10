local M = {}

function M.nvim_config_dir()
    return vim.fn.stdpath('config')
end

function M.nvim_data_dir()
    return vim.fn.stdpath('data')
end

function M.get_nvim_config_dir(path)
    return M.nvim_config_dir() .. "/" .. path
end

function M.get_nvim_data_dir(path)
    return M.nvim_data_dir() .. "/" .. path
end

return M
