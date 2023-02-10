local path = require('utils.path')

local neovide_persist_fullscreen_file = path.get_nvim_data_path('neovide-fullscreen.txt')
local neovide_extended_settings_file_path = path.get_nvim_data_path('neovide-settings-extended.json')
local neovide_persist_restart_session_file = path.get_nvim_data_path('neovide-restart-session.vim')

local read_neovide_settings = function ()
    if !path.file_exists(neovide_persist_fullscreen_file) then
        return {}
    else
        -- TODO: Read settings file and parse json
    end
end
