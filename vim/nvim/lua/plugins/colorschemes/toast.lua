local M = {}

local scheme = {
	default = 'toast',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
