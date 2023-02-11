local M = {}

local default_opts = { noremap = true, silent = true }

local apply_keymap = function (mode, chord, action, opts)
	opts = opts or default_opts
    vim.keymap.set(mode, chord, action, opts)
end

M.set = function (modes, chord, action, opts)
	apply_keymap(modes, chord, action, opts)
end

M.all = function (chord, action, opts)
	apply_keymap({ 'n', 'i', 'v', 'c', 't' }, chord, action, opts)
end

M.normal = function (chord, action, opts)
	apply_keymap('n', chord, action, opts)
end

M.insert = function (chord, action, opts)
	apply_keymap('i', chord, action, opts)
end

M.visual = function (chord, action, opts)
	apply_keymap('v', chord, action, opts)
end

M.command = function (chord, action, opts)
	apply_keymap('c', chord, action, opts)
end

M.terminal = function (chord, action, opts)
	apply_keymap('t', chord, action, opts)
end

M.select = function (chord, action, opts)
	apply_keymap('s', chord, action, opts)
end

M.visual_only = function (chord, action, opts)
	apply_keymap('x', chord, action, opts)
end

return M
