local M = {}

local scheme = {
	default = 'default',
	atlantis = 'atlantis',
	andromeda = 'andomeda',
	shusia = 'shusia',
	maia = 'maia',
}

M.config = function ()
	vim.g.sonokai_style = scheme.default
	vim.cmd.colorscheme('sonokai')
end

return M
