local M = {}

local scheme = {
	default = 'nord',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
