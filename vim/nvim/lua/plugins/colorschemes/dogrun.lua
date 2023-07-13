local M = {}

local scheme = {
	default = 'dogrun',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
