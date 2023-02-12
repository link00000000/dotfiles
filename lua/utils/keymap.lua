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

local lazy_keymap = function (modes, chord, action, opts)
    opts = merge_default_opts(opts)

    local map = {
        chord,
        action,
        mode = modes,
    }

    return vim.tbl_deep_extend("force", opts, map)
end

local create_keymap = function (modes, chord, action, opts)
    return {
        apply = function ()
            apply_keymap(modes, chord, action, opts)
        end,
        lazy = lazy_keymap(modes, chord, action, opts),
    }
end

M.set = function (modes, chord, action, opts)
    return create_keymap(modes, chord, action, opts)
end

M.all = function (chord, action, opts)
    return create_keymap({ 'n', 'i', 'v', 'c', 't' }, chord, action, opts)
end

M.normal = function (chord, action, opts)
    return create_keymap('n', chord, action, opts)
end

M.insert = function (chord, action, opts)
    return create_keymap('i', chord, action, opts)
end

M.visual = function (chord, action, opts)
    return create_keymap('v', chord, action, opts)
end

M.command = function (chord, action, opts)
    return create_keymap('c', chord, action, opts)
end

M.terminal = function (chord, action, opts)
    return create_keymap('t', chord, action, opts)
end

M.select = function (chord, action, opts)
    return create_keymap('s', chord, action, opts)
end

M.visual_only = function (chord, action, opts)
    return create_keymap('x', chord, action, opts)
end

return M
