# ALIASES{{{
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."
alias -g ......="../../../../.."

alias ls="ls --color=always --group-directories-first"
alias ll="ls -lh"
alias la="ls -AC"
alias ld="ls -lhdA"
alias lr="ls -lhAR"

alias tree="tree -shaCF --dirsfirst"
alias df="df -hT"
alias du="du-func"
alias lsblk="lsblk -o NAME,FSTYPE,SIZE,OWNER,GROUP,MODE,MOUNTPOINT"

alias jobs="jobs -l"
alias mkdir="mkdir -pv"

alias mv="mv -i"
alias cp="cp -iR"
alias rm="rm -i"
alias ff="\find . -iname"
alias fa="sudo find / -iname"
alias ping="ping -c 4 -i 0.2"
alias pingtest="sudo \ping -qc 4 -i 0.1 8.8.8.8"
alias rsync="rsync -rP"
alias KILL="kill -s KILL"

alias reboot="sudo reboot"
alias shutdown="sudo shutdown -P +1"
alias noshut="sudo shutdown -c"

alias sudo="sudo "
alias lspci="sudo lspci"
alias lsmod="sudo lsmod"
alias mount="sudo mount -ouid=kous,gid=kous"

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
