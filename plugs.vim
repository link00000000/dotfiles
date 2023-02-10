" Install vim-plug if it is not already installed
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

    " Layout / Statusline / Tabline
    " Plug 'link00000000/nvim-ide'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'link00000000/luatab.nvim'
    Plug 'numtostr/FTerm.nvim'
    "Plug 'ldelossa/buffertag'
    Plug 'jghauser/shade.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'j-hui/fidget.nvim'
    " Plug 'luukvbaal/statuscol.nvim'
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'utilyre/barbecue.nvim'

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
    Plug 'zbirenbaum/copilot.lua'
    Plug 'adamclerk/vim-razor' " Can be removed if razor is ever supported by omnisharp lsp
    Plug 'pierreglaser/folding-nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'mrjones2014/nvim-ts-rainbow' " Requires nvim-treesitter
    Plug 'folke/trouble.nvim'
    Plug 'simrat39/symbols-outline.nvim'
    Plug 'SmiteshP/nvim-navic'

    " DAP / Debugging
    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'

    " Testing
    Plug 'nvim-neotest/neotest'
    Plug 'Issafalcon/neotest-dotnet' " Requires nvim-neotest/neotest

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
    Plug 'ggandor/leap.nvim'

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
    Plug 'wadackel/vim-dogrun'
    Plug 'folke/tokyonight.nvim'
    Plug 'srcery-colors/srcery-vim'

    " Git / Version Control
    Plug 'lewis6991/gitsigns.nvim'

    " Misc.
    Plug 'goolord/alpha-nvim'
    Plug 'jackMort/ChatGPT.nvim'

    " Libraries / Dependencies
    Plug 'nvim-lua/plenary.nvim' " Required by telescope
    Plug 'rafcamlet/nvim-luapad'
    Plug 'kkharji/sqlite.lua' " Required by nvim-telescope/telescope-smart-history.nvim
    Plug 'mortepau/codicons.nvim'
    Plug 'MunifTanjim/nui.nvim' " Required by jackMort/ChatGPT.nvim
    Plug 'tpope/vim-repeat' " Required by ggandor/leap.nvim

call plug#end()

lua require('configs.colorscheme')
lua require('configs.codicons')
"lua require('configs.nvim-ide')
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
lua -- require('configs.shade') -- Buffer tags do not show if shade is enabled
"lua require('configs.buffertag')
lua require('configs.sqlite')
lua require('configs.gitsigns')
lua require('configs.lualine')
lua require('configs.fidget')
lua require('configs.nvim-tree')
" lua require('configs.statuscol')
lua require('configs.trouble')
lua require('configs.symbols-outline')
lua require('configs.neotest')
lua require('configs.nvim-navic')
lua require('configs.barbecue')

lua << EOF
require("chatgpt").setup({
  welcome_message = WELCOME_MESSAGE, -- set to "" if you don't like the fancy godot robot
  loading_text = "loading",
  question_sign = "", -- you can use emoji if you want e.g. 🙂
  answer_sign = "ﮧ", -- 🤖
  max_line_length = 120,
  yank_register = "+",
  chat_layout = {
    relative = "editor",
    position = "50%",
    size = {
      height = "80%",
      width = "80%",
    },
  },
  settings_window = {
    border = {
      style = "rounded",
      text = {
        top = " Settings ",
      },
    },
  },
  chat_window = {
    filetype = "chatgpt",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top = " ChatGPT ",
      },
    },
  },
  chat_input = {
    prompt = "  ",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top_align = "center",
        top = " Prompt ",
      },
    },
  },
  openai_params = {
    model = "text-davinci-003",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 300,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  openai_edit_params = {
    model = "code-davinci-edit-001",
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  keymaps = {
    close = { "<C-c>", "<Esc>" },
    yank_last = "<C-y>",
    scroll_up = "<C-u>",
    scroll_down = "<C-d>",
    toggle_settings = "<C-o>",
    new_session = "<C-n>",
    cycle_windows = "<Tab>",
  },
})
EOF
