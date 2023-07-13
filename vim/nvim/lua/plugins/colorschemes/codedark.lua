local M = {}

local scheme = {
	default = 'codedark',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
