local copilot = require('copilot')
local copilot_suggestion = require('copilot.suggestion')

copilot.setup({
    panel = {
        enabled = true,
        auto_refresh = true,
    },
    suggestion = {
        enabled = false,
        auto_trigger = true,
    }
})

vim.keymap.set('i', '<Esc>',
	function ()
		if copilot_suggestion.is_visible() then
			copilot_suggestion.dismiss()
		else
			vim.cmd("stopinsert")
		end
	end,
{})

vim.keymap.set('i', '<Tab>',
    function ()
        if copilot_suggestion.is_visible() then
            copilot_suggestion.accept()
        else
            vim.cmd('execute "normal! a\\<Tab>"')
        end
    end,
{})
