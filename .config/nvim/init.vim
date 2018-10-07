" nvim configuration for limbo
" 2017/11/18
filetype off                  " required
set termguicolors
colorscheme antares

execute pathogen#infect()

let g:miniBufExplMapWindowNavVim = 1

let g:vimtex_view_method = 'mupdf'
let g:vimtex_fold_enabled = 1

let g:scratch_insert_autohide = 0
let g:scratch_horizontal = 0
let g:scratch_height = 40

let g:ledger_maxwidth = 80
let g:ledger_fillstring = "- -"
let g:ledger_fold_blanks = 0

" custom functions
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" misc settings
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
set wildmode=longest:full,full
set wildignore=*.o,*~,*.bak,*.pdf
set conceallevel=0 concealcursor=nvc
set nojoinspaces
set gdefault
set updatetime=100

" status line
set statusline=%f\ 		" relative file path
set statusline+=[%Y%M]		" filetype:modified
set statusline+=%=		" right align
set statusline+=(%02B)-		" hex value under cursor
set statusline+=%l.%02c		" current line.column
set statusline+=\ of\ %L	" of lines

" autocmds
augroup filetype
	autocmd!
	" Remove all vimrc autocommands
	autocmd BufRead,BufNewFile *.h		:setlocal filetype=c
	autocmd BufRead,BufNewFile *.ode	:setlocal filetype=xppaut
	autocmd Filetype c			:setlocal foldmethod=syntax
	autocmd Filetype c			:setlocal cinoptions=:0
	autocmd Filetype tex			:setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell
	autocmd Filetype tex			:nnoremap <buffer> <leader>p :w<cr>:!pdflatex %<cr>
	" autocmd BufRead,BufNewFile /home/kous/work/umbc/18-fall/math490/answer-key/* :nnoremap <buffer> <leader>p :w<cr>:!pdflatex -output-directory=output main.tex<cr>
	autocmd Filetype vim,zsh,conf,text,make	:setlocal foldmethod=marker
	" autocmd Filetype ledger			:nnoremap <buffer> <leader>a :AlignLedger<cr>
	" autocmd Filetype ledger			:nnoremap <buffer> <leader>A ggVG:AlignLedger<cr>
	autocmd Filetype text			:nnoremap spell wrap
	" autocmd FileType ocaml setlocal commentstring=#\ %s #
	autocmd Filetype rust			:let g:rust_recommended_style = 0
	autocmd Filetype rust			:setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell
augroup END

