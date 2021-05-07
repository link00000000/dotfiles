" setup folds {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" plugins {{{

" Plugins managed by dein
" https://github.com/Shougo/dein.vim

" Required:
if &compatible
  set nocompatible
endif

" Install dein if is not already installed
if empty(globpath("~/.cache/dein/repos/github.com/Shougo/dein.vim", "*"))
    echo "Installing dein.vim..."

    " OS stored in g:os
    " Possible values:
    "   'Windows'
    "   'Darwin'
    "   'Linux'
    if !exists("g:os")
        if has("win64") || has("win32") || has("win16")
            let g:os = "Windows"
        else
            let g:os = substitute(system('uname'), '\n', '', '')
        endif
    endif

    if g:os == "Windows"
        execute "!Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1"
        execute "!Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser"
        execute "!./installer.ps1 ~/.cache/dein"
        execute "!rm ./installer.ps1"
    elseif g:os == "Linux" || g:os == "Darwin"
        execute "!curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh"
        execute "!sh ./installer.sh ~/.cache/dein"
        execute "!rm ./installer.sh"
    else
        echo "Dein.vim must be installed manually. See https://github.com/Shougo/dein.vim"
    endif

endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.cache/dein')

" Let dein manage dein
call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

" Plugins:
    " Plugin Management
    call dein#add('wsdjeg/dein-ui.vim')

    " Language Specific

        " Fish
        call dein#add('dag/vim-fish')

        " Python
        call dein#add('davidhalter/jedi-vim')

    " Other
    call dein#add('itchyny/lightline.vim')
    call dein#add('kien/ctrlp.vim')
    call dein#add('Shougo/defx.nvim')

" Required:
call dein#end()

" Install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" }}}

" configs {{{

set nocompatible

" Word wrapping
set nowrap        " Do not wrap lines

" Indentation
set expandtab     " Use spaces instead of tabs
set smarttab
set shiftwidth=4  " Indent with 4 spaces
set tabstop=4     " Indent with 4 spaces

" Colors and Themeing
highlight Normal           guifg=#dfdfdf ctermfg=15   guibg=#282c34 ctermbg=0     cterm=none
highlight LineNr           guifg=#5b6268 ctermfg=8    guibg=#282c34 ctermbg=0     cterm=none
highlight CursorLineNr     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
highlight VertSplit        guifg=#1c1f24 ctermfg=0    guifg=#5b6268 ctermbg=8     cterm=none
highlight Statement        guifg=#98be65 ctermfg=2    guibg=none    ctermbg=none  cterm=none
highlight Directory        guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
highlight StatusLine       guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
highlight StatusLineNC     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
highlight Comment          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=italic
highlight Constant         guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
highlight Special          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
highlight Identifier       guifg=#5699af ctermfg=6    guibg=none    ctermbg=none  cterm=none
highlight PreProc          guifg=#c678dd ctermfg=5    guibg=none    ctermbg=none  cterm=none
highlight String           guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
highlight Number           guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
highlight Function         guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
highlight Visual           guifg=#dfdfdf ctermfg=none guibg=#1c1f24 ctermbg=8     cterm=none
highlight Folded           guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=italic
highlight FoldColumn       guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=italic

" Gutter

    " Enable line numbers
    set relativenumber
    set number

" Shougo/dein.vim
    filetype plugin indent on
    syntax enable

" itchyny/lightline

    " lightline theme
    let g:lightline = {
        \ 'colorscheme': 'darcula',
        \ }

    " Always show statusline
    let laststatus=2

" }}}

" functions {{{

" Alias :W to :w
command W w

" Alias :PUpdate to :DeinUpdate
command PUpdate DeinUpdate

" }}}

" mappings {{{
" }}}
