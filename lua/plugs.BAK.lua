local load_config = require('utils.load_config')

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function (use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Layout / Statusline / Tabline

    use {
        'link00000000/luatab.nvim',
        requires = {
            { 'kyazdani42/nvim-web-devicons', config = function () require('configs.nvim-web-devicons') end },
        },
        config = function () require('configs.luatab') end
    }

    use { 'numtostr/FTerm.nvim', config = function () require('configs.fterm') end }

    use { 'ldelossa/buffertag', config = function () require('configs.buffertag') end }

    use { 'nvim-lualine/lualine.nvim', config = function () require('configs.lualine') end }

    -- LSP / Intellisense / Autocompletion / Syntax / Highlighting
    use {
	    'neovim/nvim-lspconfig',
        requires = {
            -- Laguange Servers
            { 'williamboman/mason.nvim', config = function () require('configs.mason') end },
            { 'williamboman/mason-lspconfig.nvim', config = function () require('configs.mason-lspconfig') end },
            'Hoffs/omnisharp-extended-lsp.nvim',
            'folke/neodev.nvim',
            
            -- UI
            { 'j-hui/fidget.nvim', config = function () require('configs.fidget') end },
        },
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'onsails/lspkind.nvim',
        },
        config = function () require('configs.nvim-cmp') end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function ()
            pcall(require('nvim-treesitter.install').update({ with_sync = true }))
        end,
        requires = { 'mrjones2014/nvim-ts-rainbow' },
        config = function () require('configs.nvim-treesitter') end
    }

    use { 'andymass/vim-matchup', event = 'VimEnter', }
    use { 'adamclerk/vim-razor', config = function () require('configs.razor') end }
    use { 'windwp/nvim-autopairs', config = function () require('configs.nvim-autopairs') end }


    -- DAP / Debugging
    use {
        'mfussenegger/nvim-dap',
        requires = {
            { 'rcarriga/nvim-dap-ui', config = function () require('configs.dapui') end },
            'theHamsta/nvim-dap-virtual-text',
            { 'mortepau/codicons.nvim', config = function () require('configs.codicons') end },
            { 'luukvbaal/statuscol.nvim', config = function () require('configs.statuscol') end },
        },
        config = function () require('configs.dap') end
    }

    -- Snippets
    use {
        'L3MON4D3/LuaSnip',
        requires = { 'rafamadriz/friendly-snippets' },
        config = function () require('configs.luasnip') end
    }

    -- Comments
    use { 'numToStr/Comment.nvim', config = function () require('configs.comment') end }
    use { 'folke/todo-comments.nvim', config = function () require('configs.todo-comments') end }

    -- Fuzzy Find / Search
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function () require('configs.telescope') end
    }

    use {
        'nvim-telescope/telescope-ui-select.nvim',
        requires = { 'nvim-telescope/telescope.nvim' },
    }

    use {
        'link00000000/telescope-fzf-native.nvim',
        run = 'make',
        requires = { 'nvim-telescope/telescope.nvim' },
    }

    use {
        'link00000000/telescope-repo.nvim',
        requires = { 'nvim-telescope/telescope.nvim' },
    }

    use {
        'nvim-telescope/telescope-smart-history.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
            { 'kkharji/sqlite.lua', config = function () require('configs.sqlite') end },
        },
    }

    -- Colorschemes
    use {
        'mhartington/oceanic-next',
        'arcticicestudio/nord-vim',
        'dracula/vim',
        'tomasiser/vim-code-dark',
        'folke/tokyonight.nvim',
        'sainnhe/sonokai',
        'sainnhe/edge',
        'tanvirtin/monokai.nvim',
        'Pocco81/Catppuccino.nvim',
        'navarasu/onedark.nvim',
        'EdenEast/nightfox.nvim',
        'chriskempson/base16-vim',
        'Mofiqul/vscode.nvim',
        'jsit/toast.vim',
        'LunarVim/onedarker.nvim',
        config = function () require('configs.colorscheme') end
    }

    -- Git / Version Control
    use { 'lewis6991/gitsigns.nvim', config = function () require('configs.gitsigns') end }

    -- Misc.
    use { 'goolord/alpha-nvim', config = function () require('configs.alpha') end }

    if is_bootstrap then
        require('packer').sync()
    end
end)

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever plugs.lua is saved
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

