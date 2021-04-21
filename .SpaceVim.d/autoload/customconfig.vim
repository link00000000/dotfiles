" Called before SpaceVim core
function! customconfig#before() abort
    " Improved split pane navigation
    " https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally#easier-split-navigations
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

    " j/k will move virtual lines (lines that wrap)
    " https://gist.github.com/benawad/b768f5a5bbd92c8baabd363b7e79786f
    noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
    noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

endfunction

" Called after Vim enters autocmd
function! customconfig#after() abort
endfunction
