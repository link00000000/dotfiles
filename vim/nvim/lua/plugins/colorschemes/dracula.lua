local M = {}

local scheme = {
	default = 'dracula',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
