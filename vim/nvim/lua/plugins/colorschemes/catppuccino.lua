local M = {}

local scheme = {
	default = 'catppuccin',
	latte = 'catppuccin-latte',
	frappe = 'catppuccin-frappe',
	macchiato = 'catppuccin-macchiato',
	mocha = 'catppuccin-mocha',
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
