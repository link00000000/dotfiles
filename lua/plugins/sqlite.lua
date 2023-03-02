local path = require('utils.path')
local shell = require('utils.shell')

local M = {}

local function config ()
    vim.g.sqlite_clib_path = path.get_nvim_data_dir('sqlite3/sqlite3.dll')
end

M.spec = {
    'kkharji/sqlite.lua',
    lazy = false,
    config = config,
    build = {
        shell.build_command('mkdir "' .. path.get_nvim_data_dir('sqlite3', { escape = true }) .. '"'),
        shell.build_command('curl "https://www.sqlite.org/2022/sqlite-dll-win64-x64-3400100.zip" -o "' .. path.get_nvim_data_dir('sqlite3/sqlite3.zip', { escape = true }) .. '"'),
        shell.build_command('7z x "' .. path.get_nvim_data_dir('sqlite3/sqlite3.zip', { escape = true }) .. '" -o"' .. path.get_nvim_data_dir('sqlite3', { escape = true }) .. '"'),
        shell.build_command('rm ' .. path.get_nvim_data_dir('sqlite3/sqlite3.zip', { escape = true })),
    }
}

return M
