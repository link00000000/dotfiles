local M = {}

M.spec = {
	{
		'mhartington/oceanic-next',
		lazy = false,
		config = require('plugins.colorschemes.oceanic-next').config,
		enabled = false,
	},
	{
		'arcticicestudio/nord-vim',
		lazy = false,
		config = require('plugins.colorschemes.nord').config,
		enabled = false,
	},
	{
		'dracula/vim',
		lazy = false,
		config = require('plugins.colorschemes.dracula').config,
		enabled = false,
	},
	{
		'tomasiser/vim-code-dark',
		lazy = false,
		config = require('plugins.colorschemes.codedark').config,
		enabled = false,
	},
	{
		'folke/tokyonight.nvim',
		lazy = false,
		config = require('plugins.colorschemes.tokyonight').config,
		enabled = false,
	},
	{
		'sainnhe/sonokai',
		lazy = false,
		config = require('plugins.colorschemes.sonokai').config,
		enabled = false,
	},
	{
		'sainnhe/edge',
		lazy = false,
		config = require('plugins.colorschemes.edge').config,
		enabled = false,
	},
	{
		'tanvirtin/monokai.nvim',
		lazy = false,
		config = require('plugins.colorschemes.monokai').config,
		enabled = false,
	},
	{
		'Pocco81/Catppuccino.nvim',
		lazy = false,
		config = require('plugins.colorschemes.catppuccino').config,
		enabled = false,
	},
	{
		'navarasu/onedark.nvim',
		lazy = false,
		config = require('plugins.colorschemes.onedark').config,
		enabled = false,
	},
	{
		'EdenEast/nightfox.nvim',
		lazy = false,
		config = require('plugins.colorschemes.nightfox').config,
		enabled = true,
	},
	{
		'chriskempson/base16-vim',
		lazy = false,
		config = require('plugins.colorschemes.base16').config,
		enabled = false,
	},
	{
		'Mofiqul/vscode.nvim',
		lazy = false,
		config = require('plugins.colorschemes.vscode').config,
		enabled = false,
	},
	{
		'jsit/toast.vim',
		lazy = false,
		config = require('plugins.colorschemes.toast').config,
		enabled = false,
	},
	{
		'LunarVim/onedarker.nvim',
		lazy = false,
		config = require('plugins.colorschemes.onedarker').config,
		enabled = false,
	},
	{
		'wadackel/vim-dogrun',
		lazy = false,
		config = require('plugins.colorschemes.dogrun').config,
		enabled = false,
	},
	{
		'srcery-colors/srcery-vim',
		lazy = false,
		config = require('plugins.colorschemes.srcery').config,
		enabled = false,
	}
}

return M
