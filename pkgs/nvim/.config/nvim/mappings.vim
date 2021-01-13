" LEADER
nnoremap <space> <nop>
let mapleader = " "

" COMMAND MODE
nnoremap ; :

" CLEAR SEARCH HIGHLIGHTING
nnoremap <silent> <esc> :noh<return><esc>

" DEL
nnoremap <C-d> d
vnoremap <C-d> d
nnoremap d "_d
vnoremap d "_d

" CHANGE
nnoremap <C-c> c
vnoremap <C-c> c
nnoremap c "_c
vnoremap c "_c

" CUT
nnoremap <C-x> x
vnoremap <C-x> x
nnoremap x "_x
vnoremap x "_x

" WINCMD
nnoremap <leader>w <C-w>
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>q :wincmd q<CR>

" SCROLL
nnoremap { 3<C-y><S-m>
nnoremap } 3<C-e><S-m>

" INDENTING
nnoremap <silent> <Tab> >>
vnoremap <silent> <Tab> >
nnoremap <silent> <BS> <<
vnoremap <silent> <BS> <


