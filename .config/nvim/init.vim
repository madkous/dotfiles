" nvim configuration for limbo
" 2017/11/18
filetype off                  " required
set termguicolors
colorscheme antares

" Vundle {{{
" Vundle initialisation {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" }}}

" Installed Plugins {{{
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" quick manipulation of quotes and brackets
Plugin 'tpope/vim-surround'
" repeat support for plugins
Plugin 'tpope/vim-repeat'
" sugar for unix commands
Plugin 'tpope/vim-eunuch'
" quick commenting
Plugin 'tomtom/tcomment_vim'
" increment dates
Plugin 'tpope/vim-speeddating'
" directory browsing stuff
Plugin 'tpope/vim-vinegar'
" git wrapper
Plugin 'tpope/vim-fugitive'
" show git changes
Plugin 'airblade/vim-gitgutter'
" slime for vim
" Plugin 'kovisoft/slimv'
" Plugin 'gokcehan/vim-opex'
Plugin 'wlangstroth/vim-racket'
" Gentoo and portage syntax highlighting
Plugin 'gentoo/gentoo-syntax'
" async make replacement
Plugin 'neomake/neomake'
" async completions
Plugin 'Shougo/deoplete.nvim'
" replace hex code with colour
Plugin 'hexHighlight.vim'
" latex commands
Plugin 'lervag/vimtex'
" gdb integration
Plugin 'vim-scripts/gdbmgr'
" c ide
Plugin 'vim-scripts/c.vim'
" rust ide
Plugin 'rust-lang/rust.vim'
" scratch buffer
Plugin 'mtth/scratch.vim'
" fold optimisations
Plugin 'Konfekt/FastFold'
" character column alignment
Plugin 'godlygeek/tabular'
" standard ml
Plugin 'cypok/vim-sml'
" ledger
Plugin 'ledger/vim-ledger'
" ranger
Plugin 'airodactyl/neovim-ranger'
" miniyank
" Plugin 'bfredl/nvim-miniyank'
Plugin 'tmux-plugins/vim-tmux'
" add diff option to recovery
Plugin 'chrisbra/Recover.vim'
" color utility
Plugin 'zefei/vim-colortuner'
" needed for fetching schemes online.
Plugin 'mattn/webapi-vim'
" coq syntax and indents
Plugin 'jvoorhis/coq.vim'

" Unused {{{
" Plugin 'adelarsq/Vim-Autoclose'
" Plugin 'guns/vim-sexp'
" Plugin 'Yggdroot/indentLine'
" Plugin 'pangloss/vim-javascript'
" Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'reedes/vim-thematic'
" Plugin 'eagletmt/ghcmod-vim'
" Plugin 'minibufexpl.vim'
" syntax highlighting and indentation
" Plugin 'neovimhaskell/haskell-vim'
" type checking, type information
" Plugin 'bitc/vim-hdevtools'
" haskell completions
" Plugin 'eagletmt/neco-ghc'
" vim calendar
" Plugin 'itchyny/calendar.vim'
" }}}

" Vundle finish {{{
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" }}}

" Plugin settings {{{
let g:miniBufExplMapWindowNavVim = 1

let g:vimtex_view_method = 'mupdf'
let g:vimtex_fold_enabled = 1

let g:scratch_insert_autohide = 0
let g:scratch_horizontal = 0
let g:scratch_height = 40

let g:ledger_maxwidth = 80
let g:ledger_fillstring = "- -"
let g:ledger_fold_blanks = 0

" end of plugin settings }}}
" }}}
" }}}

" custom functions {{{
" syntax highlighting {{{
" nmap <C-S-P> :call <SID>SynStack()<CR>
" function! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunction
" }}}

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

if exists('*HexHighlight()')
  nnoremap <leader>H :call HexHighlight()<Return>
endif

function! ToggleConceal()
	if &conceallevel == 2
		set conceallevel=0
		echo "Conceal Off"
	else
		set conceallevel=2
		echo "Conceal On"
	endif
endfunction

:source ~/.config/nvim/align-ledger.vim
" }}}

" misc settings {{{
set number relativenumber
set showcmd ignorecase smartcase hidden
set nowrap autowrite
set guicursor=n-c-v:block,i-ci:ver1,r-cr:hor1
set pastetoggle=<F2>
set nrformats=alpha,octal,bin,hex
set scrolloff=5
set sidescroll=1 sidescrolloff=20
set list lcs=tab:\┆\ ,trail:~,nbsp:+,extends:>,precedes:<
set nostartofline
set colorcolumn=81 textwidth=80
set complete=.,w,b,u,U,t,i,d
" let g:netrw_liststyle=3
set wildmode=longest:full,full
set wildignore=*.o,*~,*.bak,*.pdf
set conceallevel=0 concealcursor=nvc
let g:tex_conceal="agdms"
set nojoinspaces
set gdefault
set updatetime=100
" }}}

" status line {{{
set statusline=%f\ 		" relative file path
set statusline+=[%Y%M]		" filetype:modified
set statusline+=%=		" right align
set statusline+=(%02B)-		" hex value under cursor
set statusline+=%l.%02c		" current line.column
set statusline+=\ of\ %L	" of lines
" }}}

" autocmds {{{
augroup filetype
	autocmd!
	" Remove all vimrc autocommands
	autocmd BufRead,BufNewFile *.h		:setlocal filetype=c
	autocmd BufRead,BufNewFile *.ode	:setlocal filetype=xppaut
	autocmd Filetype c			:setlocal foldmethod=syntax
	autocmd Filetype c			:setlocal cinoptions=:0
	autocmd Filetype tex			:setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell
	autocmd Filetype tex			:nnoremap <buffer> <leader>p :w<cr>:!pdflatex %<cr>
	autocmd Filetype vim,zsh,conf,text,make	:setlocal foldmethod=marker
	autocmd Filetype ledger			:nnoremap <buffer> <leader>a :AlignLedger<cr>
	autocmd Filetype ledger			:nnoremap <buffer> <leader>A ggVG:AlignLedger<cr>
	autocmd Filetype text			:nnoremap spell wrap
	" autocmd FileType ocaml setlocal commentstring=#\ %s #
	autocmd Filetype rust			:let g:rust_recommended_style = 0
	autocmd Filetype rust			:setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell
	autocmd BufRead,BufNewFile /home/kous/work/umbc/18-fall/math490/answer-key/* :nnoremap <buffer> <leader>p :w<cr>:!pdflatex -output-directory=output main.tex<cr>
augroup END
" }}}

" key mappings {{{
" unmap arrowkeys {{{
map <Up> <nop>
imap <Up> <nop>
map <Left> <nop>
imap <Left> <nop>
map <Right> <nop>
imap <Right> <nop>
map <Down> <nop>
imap <Down> <nop>
" }}}

" clear search query
nnoremap <leader><space> :noh<CR>
nnoremap N Nzz
nnoremap n nzz
nmap <tab> %
vmap <tab> %
" buffer swapping
noremap <leader>h :bn<CR>
noremap <leader>l :bp<CR>
" strip whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" nnoremap <CR> O<Esc>
" nnoremap <Space> o<Esc>
nnoremap <leader>= gg=G
" open/source init.vim
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>el :vsplit ~/texmf/tex/latex/mathutils/mathutils.sty<cr>
nnoremap <leader>w :write<cr>
nnoremap <leader>r :resize 60<cr>
nnoremap <leader>R :redraw!<cr>
nnoremap <leader>C :call ToggleConceal()<CR>

" splits {{{
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>l
" navigate
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" resize
noremap <leader><C-h> 10<C-w><
noremap <leader><C-l> 10<C-w>>
noremap <leader><C-j> 5<C-w>-
noremap <leader><C-k> 5<C-w>+
noremap <leader>= <C-w>=
" }}}

" fix Y
map Y y$
" }}}

