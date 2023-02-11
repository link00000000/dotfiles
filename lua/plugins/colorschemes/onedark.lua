
local M = {}

local scheme = {
	default = 'dark',
	darker = 'darker',
	deep = 'deep',
	warp = 'warm',
	warmer = 'warmer',
	light = 'light',
}

M.config = function ()
	local onedark = require('onedark')

	onedark.setup({ style = scheme.default })
end

return M
