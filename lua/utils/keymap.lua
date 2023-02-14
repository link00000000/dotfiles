local M = {}

local function merge_default_opts (opts)
    opts = opts or {}
    local default_opts = { noremap = true, silent = true }

    return vim.tbl_deep_extend("force", default_opts, opts)
end

local apply_keymap = function (modes, chord, action, opts)
    opts = merge_default_opts(opts)
    vim.keymap.set(modes, chord, action, opts)
end

local delete_keymap = function (modes, chord, opts)
    vim.keymap.del(modes, chord, opts)
end

local lazy_keymap = function (modes, chord, action, opts)
    opts = merge_default_opts(opts)

    local map = {
        chord,
        action,
        mode = modes,
    }

    return vim.tbl_deep_extend("force", opts, map)
end

local new_keymapper = function (modes)
    return {
        apply = function (chord, action, opts)
            apply_keymap(modes, chord, action, opts)
        end,
        delete = function (chord, opts)
            delete_keymap(modes, chord, opts)
        end,
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
