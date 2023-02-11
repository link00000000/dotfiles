
local M = {}

M.config = function ()
	local vscode = require('vscode')

	vscode.setup({
		italic_comments = true,
	})
end

return M
