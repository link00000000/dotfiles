-- INFO: vtpcon = Windows terminal, powershell, cmd

local keymap = require('utils.keymap')

---@type ConfigModule
return {
    setup = function ()
        -- vtpcon sends <C-S-h> instead of <C-BS>
        keymap.insert.delete('<C-BS>')
        keymap.insert.apply('<C-H>', '<C-W>')
    end
}
