local M = {}

local function load_common_config ()
	require('configs.common').setup()
end

local function load_local_config ()
    local hostname = vim.fn.hostname()
    local status, err = pcall(function ()
        require('configs.local' .. hostname).setup()
    end)
end

local function load_editor_config ()
    if vim.g.neovide ~= nil then
        require('configs.editor.neovide').setup()
    end
end

M.setup = function ()
    load_common_config()
    load_local_config()
    load_editor_config()
end

return M
