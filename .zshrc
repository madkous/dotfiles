# Created by kous for limbo

# ZSTYLE {{{
zstyle ':completion:*' completer _expand _complete _ignored  _correct _approximate _prefix
zstyle ':completion:*' completions 3
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d:'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 2
zstyle ':completion:*' insert-tab true

zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"
# }}}

autoload -Uz compinit add-zsh-hook
compinit

typeset -U path
path=(~/.local/bin $path .)

export EDITOR=/usr/bin/nvim
export MANPAGER="/usr/bin/nvim -c 'set ft=man' -"
export PAGER="/usr/bin/nvimpager"

# OPTIONS {{{
# DIRECTORIES
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS CHASE_LINKS
# COMPLETIONS
setopt LIST_PACKED
# EXPANSION
setopt EXTENDED_GLOB HIST_SUBST_PATTERN MARK_DIRS NUMERIC_GLOB_SORT RC_EXPAND_PARAM NOMATCH
# HISTORY
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY HIST_REDUCE_BLANKS
# I/O
setopt PATH_DIRS RM_STAR_WAIT NO_CLOBBER
# SHELL EMULATION
setopt APPEND_CREATE NO_BEEP
bindkey -v

ZLE_RPROMPT_INDENT=0
HISTFILE=~/.zsh_history
SAVEHIST=100000
HISTSIZE=10000
# }}}

# ALIASES {{{
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."

alias ls="ls --color=always --group-directories-first --classify"
alias ll="ls -lh"
alias la="ls -AC"
alias ld="ls -lhdA"
alias lr="ls -lhAR"

alias tree="tree -shaCF --dirsfirst"
alias df="df -hT --total -t ext4"
alias du="du-func"
alias lsblk="lsblk -o NAME,FSTYPE,SIZE,OWNER,GROUP,MODE,MOUNTPOINT"
alias free="free -hw"

alias jobs="jobs -l"
alias mkdir="mkdir -pv"
alias acpi="acpi -i"
alias grep="grep --colour=auto -nT"

alias mv="mv -nv"
alias cp="cp -nvR"
alias rm="rm -vId"
alias ff="\find . -iname"
alias fa="sudo find / -iname"
alias ping="ping -c 4 -i 0.2"
alias pingtest="sudo \ping -qc 4 -i 0.1 8.8.8.8"

alias rsync="rsync -rP"
alias ncmpc="ncmpc -c"

alias reboot="sudo reboot"
alias shutdown="sudo shutdown -P now"
alias sleep="sudo s2ram"
alias sudo="sudo "
alias lspci="sudo lspci"
alias lsmod="sudo lsmod"
alias eix-sync="sudo eix-sync"
alias etc-update="sudo etc-update"

alias emerge="sudo emerge --ask --quiet-fail --jobs=2"
alias unmerge="sudo \emerge --ask --depclean"
alias sys-upd="sudo \emerge --ask --update --deep --with-bdeps=y --changed-use \
--jobs=3 --quiet-fail @world"
alias rage-upd="sudo \emerge --ask --emptytree --jobs=3 --quiet-fail @world"

alias clear="clear; tput cup $LINES 0"
alias path="echo -e ${PATH//:/\\n}"
alias now="date +\"%A, %B %-d, %Y (%-H:%M:%S %Z)\""
alias hist="history | grep -i"

alias vi="nvim"
alias vim="nvim"
alias diff="nvim -d"
alias vinit="nvim ~/.config/nvim/init.vim"
alias zinit="nvim ~/.zshrc"
alias zsrc="source ~/.zshrc"
alias tinit="nvim ~/.tmux.conf"

alias clean="make clean"
alias manc="man -s 3"
alias manl="man -s 2"

alias -g L="| less"
alias -g G="| grep"
alias -s pdf="mupdf"
alias -s {txt,c,h,scm,tex}="vi"
alias -s mp4="mpv"
# }}}

# FUNCTIONS {{{
du-func() { \du -achd 1 $@ | sort -h }

todo() {
	if [[ "$#" -eq 1 ]] ; then
		sed -i "$1d" ~/.todo
	elif [[ "$#" -gt 1 ]] ; then
		echo "$@" >> ~/.todo
	fi
	cat -n ~/.todo
}

mkcd() {
	mkdir -p "$1" && cd "$_";
}

psl() {
	local header IFS=
	ps -eo pid,euser,etime,pcpu,cmd | {
		read -r header
		printf '%s\n' "$header"
		\grep  "${@/#/-e}"
	}
}

up() {
	if [[ "$#" < 1 ]] ; then
		cd ..
	else
		CDSTR=""
		for i in {1..$1} ; do
			CDSTR="../$CDSTR"
		done
		cd $CDSTR
	fi
}
# }}}

# PROMPT {{{
get_signal () {
	psvar[1]=`kill -l $?`
	
	# VAL=$?
	# if [[ VAL -eq 0 ]]; then
	# 	psvar=()
	# else
	# 	psvar[1]=`kill -l ${VAL}`
	# fi
}
add-zsh-hook precmd get_signal
# ❯❭ block dingbats ∘
PS1="%B%(1j.%F{magenta}.%F{green})%j%f%(!.%F{yellow}.%F{blue})%b〉%f"
RPS1="%(!.%F{yellow}.%F{blue})〈%B%f%_%(0?.%F{green}.%F{red})%v%f%b" #"%?%(1v. .)%v%f"
# }}}

# FINAL INIT {{{

function sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}

function zle-line-init zle-keymap-select {
	case $KEYMAP in
		vicmd) echo -ne '\e[1 q';;
		viins|main) echo -ne '\e[5 q';;
	esac
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N sudo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\e" sudo-command-line

# if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
# 	function zle-line-init() { echoti smkx }
# 	function zle-line-finish() { echoti rmkx }
# 	zle -N zle-line-init
# 	zle -N zle-line-finish
# fi

# bindkey "${temminfo[khome]}" beginning-of-line
# bindkey "${terminfo[kend]}" end-of-line
# bindkey "${terminfo[kdch1]}" delete-char
# bindkey "${terminfo[kich1]}" overwrite-mode

source ~/.zsh/personal.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/tmuxinator.zsh
neofetch
# }}}

