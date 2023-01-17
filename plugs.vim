" Install vim-plug if it is not already installed
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

    " Layout / Statusline / Tabline
    Plug 'link00000000/nvim-ide'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'link00000000/luatab.nvim'
    Plug 'numtostr/FTerm.nvim'
    Plug 'ldelossa/buffertag'
    Plug 'jghauser/shade.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'j-hui/fidget.nvim'
    Plug 'luukvbaal/statuscol.nvim'

    " LSP / Intellisense / Syntax / Highlightinqg
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim' " Requires nvim-lspconfig and mason.nvim
    Plug 'Hoffs/omnisharp-extended-lsp.nvim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'onsails/lspkind.nvim'
    " Plug 'zbirenbaum/copilot.lua'
    Plug 'adamclerk/vim-razor' " Can be removed if razor is ever supported by omnisharp lsp
    Plug 'pierreglaser/folding-nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'mrjones2014/nvim-ts-rainbow' " Requires nvim-treesitter

    " DAP / Debugging
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'

    " Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'

    " Comments
    Plug 'numToStr/Comment.nvim'
    Plug 'folke/todo-comments.nvim'

    " Fuzzy Find / Search
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'nvim-telescope/telescope-ui-select.nvim'
    Plug 'link00000000/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'link00000000/telescope-repo.nvim'
    Plug 'nvim-telescope/telescope-smart-history.nvim'

    " Color Schemes
    Plug 'mhartington/oceanic-next'
    Plug 'arcticicestudio/nord-vim'
    Plug 'dracula/vim'
    Plug 'tomasiser/vim-code-dark'
    Plug 'folke/tokyonight.nvim'
    Plug 'sainnhe/sonokai'
    Plug 'sainnhe/edge'
    Plug 'tanvirtin/monokai.nvim'
    Plug 'Pocco81/Catppuccino.nvim'
    Plug 'navarasu/onedark.nvim'
    Plug 'EdenEast/nightfox.nvim'
    Plug 'chriskempson/base16-vim'
    Plug 'Mofiqul/vscode.nvim'
    Plug 'jsit/toast.vim'
    Plug 'LunarVim/onedarker.nvim'

    " Git / Version Control
    Plug 'lewis6991/gitsigns.nvim'

    " Misc.
    Plug 'goolord/alpha-nvim'

    " Libraries / Dependencies
    Plug 'nvim-lua/plenary.nvim' " Required by telescope
    Plug 'rafcamlet/nvim-luapad'
    Plug 'kkharji/sqlite.lua' " Required by nvim-telescope/telescope-smart-history.nvim
    Plug 'mortepau/codicons.nvim'

call plug#end()

lua require('configs.colorscheme')
lua require('configs.codicons')
lua require('configs.nvim-ide')
lua require('configs.nvim-treesitter')
lua require('configs.telescope')
lua require('configs.nvim-web-devicons')
lua require('configs.dap')
lua require('configs.dapui')
lua require('configs.mason')
lua require('configs.mason-lspconfig')
lua require('configs.alpha')
lua require('configs.nvim-cmp')
lua require('configs.comment')
" lua require('configs.copilot')
lua require('configs.vim-razor')
lua require('configs.luatab')
lua require('configs.nvim-autopairs')
lua require('configs.luasnip')
lua require('configs.todo-comments')
lua require('configs.fterm')
" lua require('configs.shade') Buffer tags do not show if shade is enabled
lua require('configs.buffertag')
lua require('configs.sqlite')
lua require('configs.gitsigns')
lua require('configs.lualine')
lua require('configs.fidget')
lua require('configs.statuscol')
