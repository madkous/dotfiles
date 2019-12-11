" nvim configuration for limbo
" 2017/11/18
filetype off                  " required
set termguicolors
colorscheme antares

execute pathogen#infect()

" plugin settings
let g:miniBufExplMapWindowNavVim = 1

let g:vimtex_view_method = 'mupdf'
let g:vimtex_fold_enabled = 1

let g:scratch_insert_autohide = 0
let g:scratch_horizontal = 0
let g:scratch_height = 40

let g:ledger_maxwidth = 80
let g:ledger_fillstring = "- -"
let g:ledger_fold_blanks = 0

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

" custom functions
if exists('&signcolumn')  " Vim 7.4.2201
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif

" let g:gitgutter_enabled = 0
" let g:gitgutter_realtime = 0
" let g:gitgutter_sign_modified = '#'
"
" nnoremap <leader>g :GitGutterToggle<CR>
"
" misc settings
set number relativenumber
set showcmd ignorecase smartcase hidden
set nowrap autowrite modeline
set pastetoggle=<F2>
set nrformats=alpha,octal,bin,hex
set scrolloff=5
set sidescroll=1 sidescrolloff=20
set list listchars=tab:\┆\ ,trail:~,nbsp:+,extends:>,precedes:<
set nostartofline
set colorcolumn=81 textwidth=80
set complete=.,w,b,u,U,t,i,d
set wildmode=longest:full,full
set wildignore=*.o,*~,*.bak,*.pdf,*.aux,*.log,*.toc,*.thm
set nojoinspaces
set gdefault
set updatetime=100
set visualbell
set nofoldenable

" gui cursor
set guicursor=n-c-v:block " normal, visual, command mode box cursor
set guicursor+=i-ci:ver1 " insert bar (number ineffective)
set guicursor+=r-cr:hor1 " replace underscore
set guicursor+=n:InsertCursor
set guicursor+=o:ReplaceCursor " operator mode
set guicursor+=sm:Cursor "showmatch in insert mode
set guicursor+=a:blinkon0

hi InsertCursor  ctermfg=1 guifg=#ff0000 ctermbg=37  guibg=#00ff00
hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=33  guibg=#268bd2

" status line

function! Status(winnum)
	let active = a:winnum == winnr()
	let bufnum = winbufnr(a:winnum)
	let stat = ''

	function! Column()
		let vc = virtcol('.')
		let ruler_width = max([strlen(line('$')), (&numberwidth - 1)])
		let column_width = strlen(vc)

		if (&signcolumn == 'yes')
			let	ruler_width += 2
		endif

		let padding = ruler_width - column_width
		let column = ''

		if padding <= 0
			let column .= vc
		else
			" + 1 becuase for some reason vim eats one of the spaces
			let column .= repeat(' ', padding + 1) . vc
		endif

		return column . ' '
	endfunction

	if (&number == 1)
		let stat .= '%{Column()}'
	endif

	" file name
	let stat .= '%f'

	" file flags: modified, read only, help, preview, ft
	let modified = getbufvar(bufnum, '&modified')
	let stat .= modified ? ' +' : ''
	let readonly = getbufvar(bufnum, '&readonly')
	let stat .= readonly ? ' ‼' : ''

	" right side
	let stat .= '%='

	" git branch
	let branch = system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
	let branch = strcharpart(branch, 0, strlen(branch)-1)
	let repo = system("basename `git rev-parse --show-toplevel`")
	let repo = strcharpart(repo, 0, strlen(repo)-1)

	if (v:shell_error == 0)
		let stat .= repo . '/' . branch
	endif

	return stat
endfunction

function! s:RefreshStatus()
	for nr in range(1, winnr('$'))
		call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
	endfor
endfunction

augroup status
	autocmd!
	autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
augroup END

augroup projects
	autocmd BufRead,BufNewFile /home/kous/work/umbc/18-fall/math490/answer-key/* :nnoremap <buffer> <M-p> :w<cr>:!pdflatex -output-directory=output /home/kous/work/umbc/18-fall/math490/answer-key/main.tex<cr>
augroup END

" autocmds
augroup filetype
	autocmd!
	" Remove all vimrc autocommands
	autocmd BufRead,BufNewFile *.h		:setlocal filetype=c
	autocmd BufRead,BufNewFile *.ode	:setlocal filetype=xppaut
	autocmd BufRead,BufNewFile *.jl		:setlocal filetype=julia
	autocmd Filetype c			:setlocal foldmethod=syntax
	autocmd Filetype c			:setlocal cinoptions=:0
	autocmd Filetype tex			:setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell
	autocmd Filetype tex			:nnoremap <buffer> <leader>p :w<cr>:!pdflatex -output-directory=output %<cr>
	autocmd Filetype vim,zsh,conf,text,make	:setlocal foldmethod=marker
	" autocmd Filetype ledger			:nnoremap <buffer> <leader>a :AlignLedger<cr>
	" autocmd Filetype ledger			:nnoremap <buffer> <leader>A ggVG:AlignLedger<cr>
	autocmd Filetype text			:nnoremap spell wrap
	" autocmd FileType ocaml setlocal commentstring=#\ %s #
	autocmd Filetype rust			:let g:rust_recommended_style = 0
	autocmd Filetype rust			:setlocal tabstop=4 shiftwidth=4 softtabstop=4 spell
augroup END

func! WordProcessor()
	" movement changes
	noremap j gj
	noremap k gk
	" formatting options
	setlocal wrap
	setlocal linebreak
	setlocal textwidth=0 colorcolumn=
	setlocal spell
	setlocal thesaurus+=$HOME/.config/nvim/thesauri/mthesaur.txt
	setlocal complete+=s
endfu
com! WP call WordProcessor()
