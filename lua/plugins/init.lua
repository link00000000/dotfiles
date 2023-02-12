local path = require('utils.path')

local M = {}

local lazy_path = path.get_nvim_data_dir('lazy/lazy.nvim')

local function is_lazy_installed()
    return vim.loop.fs_stat(lazy_path)
end

local function install_lazy()
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazy_path,
    })
end

M.setup = function ()
    if not is_lazy_installed() then
        install_lazy()
    end

    vim.opt.rtp:prepend(lazy_path)

    require('lazy').setup({

        require('plugins.colorschemes'),

        -- Layout / Statusline / Tabline
        require('plugins.luatab'),
        require('plugins.fterm'),
        --{
            --'kyazdani42/nvim-web-devicons',
            --lazy = false,
            --config = function ()
                --
            --end
        --},
        --{
            --'link00000000/luatab.nvim',
            --lazy = false,
            --config = function ()
                --
            --end
        --},
        {
            'jghauser/shade.nvim',
            lazy = false,
            config = function ()

            end
        },
        require('plugins.lualine'),
        {
            'j-hui/fidget.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'nvim-tree/nvim-tree.lua',
            lazy = false,
            config = function ()

            end
        },
        {
            'utilyre/barbecue.nvim',
            lazy = false,
            config = function ()

            end
        },

        -- LSP / Intellisense / Syntax / Highlightinqg
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            lazy = false,
            config = function ()

            end
        },
        {
            'neovim/nvim-lspconfig',
            lazy = false,
            config = function ()

            end
        },
        {
            'williamboman/mason.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'williamboman/mason-lspconfig.nvim',
            lazy = false,
            config = function ()

            end
        }, -- Requires nvim-lspconfig and mason.nvim
        {
            'Hoffs/omnisharp-extended-lsp.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'hrsh7th/nvim-cmp',
            lazy = false,
            config = function ()

            end
        },
        {
            'hrsh7th/cmp-buffer',
            lazy = false,
            config = function ()

            end
        },
        {
            'hrsh7th/cmp-path',
            lazy = false,
            config = function ()

            end
        },
        {
            'hrsh7th/cmp-nvim-lsp',
            lazy = false,
            config = function ()

            end
        },
        {
            'hrsh7th/cmp-nvim-lua',
            lazy = false,
            config = function ()

            end
        },
        {
            'hrsh7th/cmp-cmdline',
            lazy = false,
            config = function ()

            end
        },
        {
            'saadparwaiz1/cmp_luasnip',
            lazy = false,
            config = function ()

            end
        },
        {
            'onsails/lspkind.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'zbirenbaum/copilot.lua',
            lazy = false,
            config = function ()

            end
        },
        {
            'adamclerk/vim-razor',
            lazy = false,
            config = function ()

            end
        }, -- Can be removed if razor is ever supported by omnisharp lsp
        {
            'pierreglaser/folding-nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'windwp/nvim-autopairs',
            lazy = false,
            config = function ()

            end
        },
        {
            'mrjones2014/nvim-ts-rainbow',
            lazy = false,
            config = function ()

            end
        }, -- Requires nvim-treesitter
        {
            'folke/trouble.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'simrat39/symbols-outline.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'SmiteshP/nvim-navic',
            lazy = false,
            config = function ()

            end
        },

        -- DAP / Debugging
        {
            'mfussenegger/nvim-dap',
            lazy = false,
            config = function ()

            end
        },
        {
            'rcarriga/nvim-dap-ui',
            lazy = false,
            config = function ()

            end
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            lazy = false,
            config = function ()

            end
        },

        -- Testing
        {
            'nvim-neotest/neotest',
            lazy = false,
            config = function ()

            end
        },
        {
            'Issafalcon/neotest-dotnet',
            lazy = false,
            config = function ()

            end
        }, -- Requires nvim-neotest/neotest

        -- Snippets
        {
            'L3MON4D3/LuaSnip',
            lazy = false,
            config = function ()

            end
        },
        {
            'rafamadriz/friendly-snippets',
            lazy = false,
            config = function ()

            end
        },

        -- Comments
        {
            'numToStr/Comment.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'folke/todo-comments.nvim',
            lazy = false,
            config = function ()

            end
        },

        -- Fuzzy Find / Search
        {
            'nvim-telescope/telescope.nvim',
            version = '0.1.0',
            lazy = false,
            config = function ()

            end
        },
        {
            'nvim-telescope/telescope-ui-select.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'link00000000/telescope-fzf-native.nvim',
            build = 'make',
            lazy = false,
            config = function ()

            end
        },
        {
            'link00000000/telescope-repo.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'nvim-telescope/telescope-smart-history.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'ggandor/leap.nvim',
            lazy = false,
            config = function ()

            end
        },

        -- Git / Version Control
        {
            'lewis6991/gitsigns.nvim',
            lazy = false,
            config = function ()

            end
        },

        -- Misc.
        {
            'goolord/alpha-nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'jackMort/ChatGPT.nvim',
            lazy = false,
            config = function ()

            end
        },

        -- Libraries / Dependencies
        {
            'nvim-lua/plenary.nvim',
            lazy = false,
            config = function ()

            end
        }, -- Required by telescope
        {
            'rafcamlet/nvim-luapad',
            lazy = false,
            config = function ()

            end
        },
        {
            'kkharji/sqlite.lua',
            lazy = false,
            config = function ()

            end
        }, -- Required by nvim-telescope/telescope-smart-history.nvim
        {
            'mortepau/codicons.nvim',
            lazy = false,
            config = function ()

            end
        },
        {
            'MunifTanjim/nui.nvim',
            lazy = false,
            config = function ()

            end
        }, -- Required by jackMort/ChatGPT.nvim
        {
            'tpope/vim-repeat',
            lazy = false,
            config = function ()

            end
        }, -- Required by ggandor/leap.nvim

    })
end

return M
