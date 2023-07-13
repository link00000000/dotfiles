local M = {}

local scheme = {
	default = 'srcery',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
