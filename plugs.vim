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

    " LSP / Intellisense / Syntax / Highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim' " Requires nvim-lspconfig and mason.nvim
    Plug 'Hoffs/omnisharp-extended-lsp.nvim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'onsails/lspkind.nvim'

    " Snippets
    Plug 'L3MON4D3/LuaSnip'

    " Fuzzy Find / Search
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'nvim-telescope/telescope-ui-select.nvim'
    Plug 'link00000000/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'cljoly/telescope-repo.nvim'

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

    " Misc.
    Plug 'goolord/alpha-nvim'
    Plug 'bfredl/nvim-luadev'
    Plug 'numToStr/Comment.nvim'

    " Libraries / Dependencies
    Plug 'nvim-lua/plenary.nvim' " Required by telescope
    Plug 'airblade/vim-rooter'

call plug#end()

lua require('configs.colorscheme')
lua require('configs.nvim-ide')
lua require('configs.nvim-treesitter')
lua require('configs.telescope')
lua require('configs.nvim-web-devicons')
lua require('configs.mason')
lua require('configs.mason-lspconfig')
lua require('configs.alpha')
lua require('configs.nvim-cmp')
lua require('configs.comment')
