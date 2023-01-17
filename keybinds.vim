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
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Indent and outdent with <Tab> and <S-Tab>
nnoremap <silent> <Tab> >gv
vnoremap <silent> <Tab> >gv

nnoremap <silent> <S-Tab> <gv
vnoremap <silent> <S-Tab> <gv
inoremap <silent> <S-Tab> <C-o><<

" Use number keys to jump to tab
nnoremap <silent> 1 1gt
nnoremap <silent> 2 2gt
nnoremap <silent> 3 3gt
nnoremap <silent> 4 4gt
nnoremap <silent> 5 5gt
nnoremap <silent> 6 6gt
nnoremap <silent> 7 7gt
nnoremap <silent> 8 8gt
nnoremap <silent> 9 9gt
nnoremap <silent> 0 :tablast<CR>

" Move tabs
nnoremap <silent> + :tabmove +1<CR>
nnoremap <silent> _ :tabmove -1<CR>

" Open new tab
nmap <silent> <Leader>tn :Texplore getcwd()<CR>

" Clear search highlighting on <CR>
" Search stays in register so <n> and <C-n> will re-highlight results
nnoremap <silent> <CR> :nohlsearch<CR>

" Delete current buffer
nnoremap <silent> <Leader>bd :bd<CR>

" Delete previous word
imap <C-BS> <C-W>

" Open terminal in current window
nnoremap <C-w><C-Enter> :terminal<CR>
nnoremap <C-w><Enter> :terminal<CR>

" Exit terminal insert mode with <Esc> or <C-n>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-n> <C-\><C-n>

" Resize buffers with arrow keys
nnoremap <silent> <S-Up> <CMD>resize +5<CR>
nnoremap <silent> <S-Down> <CMD>resize -5<CR>
nnoremap <silent> <S-Left> <CMD>vert resize -5<CR>
nnoremap <silent> <S-Right> <CMD>vert resize +5<CR>

nnoremap <silent> <Up> <CMD>resize +1<CR>
nnoremap <silent> <Down> <CMD>resize -1<CR>
nnoremap <silent> <Left> <CMD>vert resize -1<CR>
nnoremap <silent> <Right> <CMD>vert resize +1<CR>

" Scroll without moving the cursor
nnoremap <C-S-k> <C-y>
nnoremap <C-S-j> <C-u>
