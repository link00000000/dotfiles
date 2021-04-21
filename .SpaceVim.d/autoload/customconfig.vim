" Called before SpaceVim core
function! customconfig#before() abort
    " Improved split pane navigation
    " https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally#easier-split-navigations
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

endfunction

" Called after Vim enters autocmd
function! customconfig#after() abort
endfunction
