local M = {}

local scheme = {
	default = "tokyonight",
	night = "tokyonight-night",
	storm = "tokyonight-storm",
	day = "tokyonight-day",
	moon = "tokyonight-moon",
}

M.config = function ()
	vim.cmd.colorscheme(scheme.default)
end

return M
