--local load_config = require('utils.load_config')

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
            { 'kyazdani42/nvim-web-devicons', },
        },
    }

    use { 'numtostr/FTerm.nvim', }

    use { 'ldelossa/buffertag', }

    use { 'nvim-lualine/lualine.nvim' }

    -- LSP / Intellisense / Autocompletion / Syntax / Highlighting
    use {
	    'neovim/nvim-lspconfig',
        requires = {
            -- Laguange Servers
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'Hoffs/omnisharp-extended-lsp.nvim',
            'folke/neodev.nvim',
            
            -- UI
            'j-hui/fidget.nvim',

            -- Functionality
            'pierreglaser/folding-nvim',
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
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function ()
            pcall(require('nvim-treesitter.install').update({ with_sync = true }))
        end,
        requires = { 'mrjones2014/nvim-ts-rainbow' },
    }

    use { 'andymass/vim-matchup', event = 'VimEnter', }
    use { 'adamclerk/vim-razor', }
    use { 'windwp/nvim-autopairs', }


    -- DAP / Debugging
    use {
        'mfussenegger/nvim-dap',
        requires = {
            { 'rcarriga/nvim-dap-ui', },
            'theHamsta/nvim-dap-virtual-text',
            { 'mortepau/codicons.nvim', },
            { 'luukvbaal/statuscol.nvim', },
        },
    }

    -- Snippets
    use {
        'L3MON4D3/LuaSnip',
        requires = { 'rafamadriz/friendly-snippets' },
    }

    -- Comments
    use { 'numToStr/Comment.nvim', }
    use { 'folke/todo-comments.nvim', }

    -- Fuzzy Find / Search
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.0',
        requires = { 'nvim-lua/plenary.nvim' },
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
            { 'kkharji/sqlite.lua', },
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
    }

    -- Git / Version Control
    use { 'lewis6991/gitsigns.nvim', }

    -- Misc.
    use { 'goolord/alpha-nvim', }

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

-- Load config files in config/
-- adaptation of https://github.com/mrjones2014/load-all.nvim
local ok, scan = pcall(require, 'plenary.scandir')
local plenary_log = require('plenary.log')
local log = plenary_log.new({ modes = ['trace'], plugin = 'profile', use_file = true })
if ok then
    for _, file in ipairs(scan.scan_dir(vim.fn.stdpath('config') .. '/lua/configs', { depth = 0 })) do
        log.info('Start ' .. file)
        dofile(file)
        log.info('End ' .. file)
    end
end

