local path = require('utils.path')
local shell = require('utils.shell')

local M = {}

local function config ()
    vim.g.sqlite_clib_path = path.resolve_nvim_data_dir_path('sqlite3/sqlite3.dll')
end

M.spec = {
    'kkharji/sqlite.lua',
    lazy = true,
    config = config,
    build = {
        shell.build_command('mkdir "' .. path.resolve_nvim_data_dir_path('sqlite3', { escape = true }) .. '"'),
        shell.build_command('curl "https://www.sqlite.org/2022/sqlite-dll-win64-x64-3400100.zip" -o "' .. path.resolve_nvim_data_dir_path('sqlite3/sqlite3.zip', { escape = true }) .. '"'),
        shell.build_command('7z x "' .. path.resolve_nvim_data_dir_path('sqlite3/sqlite3.zip', { escape = true }) .. '" -o"' .. path.resolve_nvim_data_dir_path('sqlite3', { escape = true }) .. '"'),
        shell.build_command('rm ' .. path.resolve_nvim_data_dir_path('sqlite3/sqlite3.zip', { escape = true })),
    }
}

return M
