local M = {}

local scheme = {
	default = 'default',
	aura = 'aura',
	neon = 'neon'
}

M.config = function ()
	vim.g.edge_style = scheme.default
	vim.cmd.colorscheme('edge')
end

return M
