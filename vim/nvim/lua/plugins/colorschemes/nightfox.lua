
local M = {}

local scheme = {
	default = 'nightfox',
	day = 'dayfox',
	dawn = 'dawnfox',
	dusk = 'duskfox',
	nord = 'nordfox',
	tera = 'terafox',
	carbon = 'carbonfox',
}

M.config = function ()
	local nightfox = require('nightfox')
	local nightfox_palette = require('nightfox.palette')

	nightfox.setup()

	local scheme = scheme.carbon
	local palette = nightfox_palette.load(scheme)

	vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = palette.bg0, bg = palette.yellow.base, })
	vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = palette.bg0, bg = palette.blue.base, })
	vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = palette.bg0, bg = palette.magenta.base, })

	vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = palette.red.base })
	vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = palette.red.base })
	vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = palette.red.base })
	vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = palette.red.base })
	
	vim.cmd.colorscheme(scheme)
end

return M