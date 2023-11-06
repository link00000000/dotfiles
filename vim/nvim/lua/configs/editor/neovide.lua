local path = require('utils.path')
local keymap = require('utils.keymap')
local command = require('utils.command')
local file = require('utils.file')

local M = {}

local extended_settings_file_path = path.get_nvim_data_dir('neovide-settings-extended.json')
local persist_restart_session_file_path = path.get_nvim_data_dir('neovide-restart-session.vim')

local function read_extended_neovide_settings ()
    local extended_settings = file.read_json(extended_settings_file_path)

    if extended_settings ~= nil and extended_settings['fullscreen'] == nil then
        extended_settings['fullscreen'] = false
    else
        if extended_settings ~= nil and type(extended_settings['fullscreen']) ~= 'boolean' then
            extended_settings['fullscreen'] = false
        end
    end

    return extended_settings
end

local function write_extended_neovide_settings (object)
    file.write_json(extended_settings_file_path, object)
end

local function toggle_fullscreen ()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen

    local extended_neovide_settings = read_extended_neovide_settings()
    extended_neovide_settings.fullscreen = vim.g.neovide_fullscreen

    write_extended_neovide_settings(extended_neovide_settings)
end

local function restart ()
    vim.api.nvim_command('mksession! ' .. persist_restart_session_file_path)
    vim.fn.system('neovide -- -S ' .. persist_restart_session_file_path)
    vim.api.nvim_command('qa!')
end

local function set_scale (factor)
    if factor > 0 then
        vim.g.neovide_scale_factor = factor
    end
end

local function scale_command_handler (opts)
    local arg = opts.args
    if arg == "reset" or arg == "default" then
        set_scale(1)
    else
        set_scale(tonumber(arg))
    end
end

M.setup = function ()
    local extended_settings = read_extended_neovide_settings()
    vim.g.neovide_fullscreen = extended_settings ~= nil and extended_settings['fullscreen']

    keymap.normal.apply('<F11>', toggle_fullscreen)

    command.create('ToggleFullscreen', toggle_fullscreen)
    command.create('Restart', restart)
    command.create('Scale', scale_command_handler, { nargs = 1 })
end

return M
