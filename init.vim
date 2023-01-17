function GetConfigDir()
    return has('nvim') ? stdpath('config') : '~/.vim'
endfunction

function GetDataDir()
    return has('nvim') ? stdpath('data') : '~/.vim/data'
endfunction

set nocompatible
set termguicolors
set updatetime=100

" Highlight the current line with the cursor
set cursorline

" Map <Space> to leader
nnoremap <Space> <NOP>
let mapleader = " "

" Enabled mouse supoort
set mouse=a

" Use system clipboard
set clipboard^=unnamed,unnamedplus

" Disabled word wrap
set nowrap

" Force word wrapping for markdown
augroup markdown_config
    autocmd!

    autocmd FileType markdown set wrap
    autocmd FileType markdown set linebreak

augroup END

" Split panes
set splitbelow
set splitright

" Indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Ignore case when searching if search contains only lower case
set ignorecase
set smartcase

" Show a few lines of context around the cursor.
set scrolloff=5 sidescrolloff=10

" Do not extend comments on enter
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Always delete previous word when deleting entire words
" https://vim.fandom.com/wiki/Map_Ctrl-Backspace_to_delete_previous_word
set backspace=indent,eol,start

" Enable line numbers
set number

" Disable error bell sound
set visualbell
set noerrorbells

" Show all folds expanded when file is open
set foldlevel=99

" Hide ./ and ../ in netrw
let g:netrw_list_hide = '^\.*/$'
let g:netrw_hide = 1

" Terminal
augroup neovim_terminal
    autocmd!

    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert

    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
augroup END

" Have only one status bar
" TODO: Maybe remove after installing statusbar plugin?
set laststatus=3

" Edit and source configuration with commands
command Config execute('e ' . GetConfigDir())
command ConfigCwd execute('tcd ' . GetConfigDir() . ' | e init.vim')
command Source execute('source ' . GetConfigDir() . '/init.vim')

if exists("g:neovide")
    execute 'source ' GetConfigDir() . '/neovide.vim'
endif

if filereadable(GetConfigDir() . '/local-configs/' . hostname() . '.vim')
    execute 'source ' GetConfigDir() . '/local-configs/' . hostname() . '.vim'
end

execute 'lua require("plugs")'
execute 'source ' GetConfigDir() . '/keybinds.vim'
