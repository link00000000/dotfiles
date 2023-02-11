local M = {}

local scheme = {
	default = 'OceanicNext',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
