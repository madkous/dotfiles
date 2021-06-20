" nvim configuration for limbo
" 2017/11/18
set termguicolors
colorscheme antares

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

" autocmds
augroup filetype
	au!
	" Remove all vimrc autocommands
	au BufRead,BufNewFile *.h		:setlocal filetype=c
augroup END

" vim -b: edit binary using xxd-format
augroup binary
	au!
	au BufReadPre   *.bin let &bin=1
	au BufReadPost  *.bin if &bin | %!xxd
	au BufReadPost  *.bin set ft=xxd | endif
	au BufWritePre  *.bin if &bin | %!xxd -r
	au BufWritePre  *.bin endif
	au BufWritePost *.bin if &bin | %!xxd
	au BufWritePost *.bin set nomod | endif
augroup END

