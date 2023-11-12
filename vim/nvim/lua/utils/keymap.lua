---@alias mode "n"|"i"|"v"|"c"|"t"|"s"|"x"

-- TODO: Use mapx.nvim for key mapping. It supports keymaps per filetype
local func = require('utils.func')

local M = {}

local merge_default_opts = func.create_merge_default_opts({ noremap = true, silent = true })

---@param modes mode[]|mode
---@param chord string
---@param action string|function
---@param opts table
local apply_keymap = function (modes, chord, action, opts)
    opts = merge_default_opts(opts)
    vim.keymap.set(modes, chord, action, opts)
end

---@param modes mode[]|mode
---@param chord string
---@param opts table
local delete_keymap = function (modes, chord, opts)
    vim.keymap.del(modes, chord, opts)
end

---@param modes mode[]|mode
---@param chord string
---@param action string|function
---@param opts table
local lazy_keymap = function (modes, chord, action, opts)
    opts = merge_default_opts(opts)

    local map = {
        chord,
        action,
        mode = modes,
    }

    return vim.tbl_deep_extend("force", opts, map)
end

---@param modes mode[]|mode
local new_keymapper = function (modes)
    return {
        ---@type fun(chord: string, action: string|function, opts: table?)
        apply = function (chord, action, opts)
            apply_keymap(modes, chord, action, opts)
        end,
        ---@type fun(chord: string, opts: table?)
        delete = function (chord, opts)
            delete_keymap(modes, chord, opts)
        end,
        ---@type fun(chord: string, action: string|function, opts: table?): table
        lazy = function (chord, action, opts)
            return lazy_keymap(modes, chord, action, opts)
        end
    }
end

M.set = function (modes)
    return new_keymapper(modes)
end

M.all = new_keymapper({ 'n', 'i', 'v', 'c', 't' })

M.normal = new_keymapper('n')

M.insert = new_keymapper('i')

M.visual = new_keymapper('v')

M.command = new_keymapper('c')

M.terminal = new_keymapper('t')

M.select = new_keymapper('s')

M.visual_only = new_keymapper('x')

return M
