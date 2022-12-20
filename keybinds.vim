" Jump to start of line
nmap B ^
vmap B ^

" Jump to end of line
nmap E $
vmap E $

" Dont include the new line when deleting until end of line
nmap D v$hd
vmap D v$hd

" Dont include the new line when replacing until end of line
nmap C v$hc
vmap C v$hc

" Make Y behave like D and C, yanking till end of line (minus the line break)
nmap Y y$
vmap Y y$

" Dont copy characters removed with 'x' to clipboard
noremap x "_x

" Don't overwrite register when pasting over selection
vnoremap p pgvy

" Move virtual lines with j and k
nmap j gj
nmap k gk

vmap j gj
vmap k gk

" Keep selection after indent
vnoremap < <gv
vnoremap > >gv

" Indent and outdent with <Tab> and <S-Tab>
nnoremap <Tab> >gv
vnoremap <Tab> >gv

nnoremap <S-Tab> <gv
vnoremap <S-Tab> <gv
inoremap <S-Tab> <C-o><<

" Use number keys to jump to tab
nnoremap 1 1gt
nnoremap 2 2gt
nnoremap 3 3gt
nnoremap 4 4gt
nnoremap 5 5gt
nnoremap 6 6gt
nnoremap 7 7gt
nnoremap 8 8gt
nnoremap 9 9gt
nnoremap <silent> 0 :tablast<CR>

" Move tabs
nnoremap <silent> + :tabmove +1<CR>
nnoremap <silent> _ :tabmove -1<CR>

" Open new tab
nmap <Leader>tn :Texplore getcwd()<CR>

" Clear search highlighting on <CR>
" Search stays in register so <n> and <C-n> will re-highlight results
nnoremap <silent> <CR> :nohlsearch<CR>

" Delete current buffer
nnoremap <silent> <Leader>bd :bd<CR>

" Exit terminal insert mode with <Esc>
tnoremap <Esc> <C-\><C-n>

" Delete previous word
imap <C-BS> <C-W>
