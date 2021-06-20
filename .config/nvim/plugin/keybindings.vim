" keybindings

" clear search query
nnoremap <leader><space> :noh<CR>
" center on find next
nnoremap N Nzz
nnoremap n nzz
" fast delimmiter movement
nmap <tab> %
vmap <tab> %
" buffer swapping
noremap <M-n> :bn<CR>
noremap <M-p> :bp<CR>
" strip whitespace
nnoremap <M-W> :%s/\s\+$//<cr>:let @/=''<CR>
" open/source init.vim
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>w :write<cr>
nnoremap <leader>r :resize 60<cr>
nnoremap <leader>R :redraw!<cr>
nnoremap <leader>C :call ToggleConceal()<CR>

" splits
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>l
" navigate
noremap <M-h> <C-w>h
noremap <M-j> <C-w>j
noremap <M-k> <C-w>k
noremap <M-l> <C-w>l
" resize
" noremap <leader><C-h> 10<C-w><
" noremap <leader><C-l> 10<C-w>>
" noremap <leader><C-j> 5<C-w>-
" noremap <leader><C-k> 5<C-w>+
" noremap <leader>= <C-w>=

" fix Y
map Y y$
