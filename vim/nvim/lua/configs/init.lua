local function load_common_config ()
	require('configs.common').setup()

    if vim.fn.has("gui_running") == 1 then
        require("configs.common-gui").setup()
    end
end

local function load_local_config ()
    local hostname = vim.fn.hostname()
    local _, err = pcall(function ()
        ---@type ConfigModule
        local module = require('configs.local.' .. hostname)
        module.setup()
    end)

    if err ~= nil then
        error(err)
    end
end

local function load_editor_config ()
    if vim.g.neovide ~= nil then
        require('configs.editor.neovide').setup()
    elseif vim.env.TERM == 'vtpcon' or vim.env.TERM == nil then
        require('configs.editor.vtpcon').setup()
    elseif vim.env.TERM == "alacritty" then
        require("configs.editor.alacritty").setup()
    end
end


---@type ConfigModule
return {
    setup = function ()
        load_common_config()
        load_local_config()
        load_editor_config()
    end
}
