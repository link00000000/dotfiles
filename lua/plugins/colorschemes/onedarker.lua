local M = {}

local scheme = {
	default = 'onedarker',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
