local path = require('utils.path')
local keymap = require('utils.keymap')

local M = {}

local extended_settings_file_path = path.get_nvim_data_dir('neovide-settings-extended.json')
local persist_restart_session_file_path = path.get_nvim_data_dir('neovide-restart-session.vim')

local function read_json_file (path)
    local file = io.open(path, 'r')

    if file == nil then
        return {}
    else
        local raw_contents = file:read('*all')
        local json = vim.json.decode(raw_contents)

        file:close()

        return json
    end
end

local function write_json_file (path, object)
    local file = io.open(path, 'w')

    local raw_contents = vim.json.encode(object)
    file:write(raw_contents)

    file:close()
end


local function read_extended_neovide_settings ()
    extended_settings = read_json_file(extended_settings_file_path)

    if extended_settings['fullscreen'] == nil then
        extended_settings['fullscreen'] = false
    else
        if type(extended_settings['fullscreen']) ~= 'boolean' then
            extended_settings['fullscreen'] = false
        end
    end

    return extended_settings
end

local function write_extended_neovide_settings (object)
    write_json_file(extended_settings_file_path, object)
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

M.keymaps = function ()
    keymap.normal('<F11>', toggle_fullscreen)
end

M.commands = function ()
    vim.api.nvim_create_user_command('ToggleFullscreen', toggle_fullscreen, {})
    vim.api.nvim_create_user_command('Restart', restart, {})
    vim.api.nvim_create_user_command('Scale', function (opts)
        local arg = opts.args
        if arg == "reset" or arg == "default" then
            set_scale(1)
        else
            set_scale(tonumber(arg))
        end
    end, { nargs = 1 })
end

M.read = read_extended_neovide_settings

M.read_json = read_json_file

M.setup = function ()
    local extended_settings = read_extended_neovide_settings()
    vim.g.neovide_fullscreen = extended_settings['fullscreen']

    M.keymaps()
    M.commands()
end

return M
