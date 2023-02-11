local M = {}

local scheme = {
	default = 'monokai',
	pro = 'monokai_pro',
	soda = 'monokai_soda',
	ristretto = 'monokai_ristretto',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
