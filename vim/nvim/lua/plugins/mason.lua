local M = {}

local function config ()
    local mason = require('mason')

    mason.setup()
end

M.spec = {
    'williamboman/mason.nvim',
    lazy = true,
    config = config,
    cmd = { 'Mason', 'MasonLog', 'MasonInstall', 'MasonInstallAll' }
}

return M
