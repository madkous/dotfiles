# ALIASES{{{
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
alias KILL="kill -s KILL"

alias reboot="sudo reboot"
alias shutdown="sudo shutdown -P +1"
alias noshut="sudo shutdown -c"
alias lock='slock -m "$(manifesto)"'
alias sleep="slock&; sudo s2ram"

alias sudo="sudo "
alias lspci="sudo lspci"
alias lsmod="sudo lsmod"
alias mount="sudo mount -ouid=kous,gid=kous"

alias eix-sync="sudo eix-sync; bell"
alias etc-update="sudo etc-update"

alias emerge="sudo emerge --alert --ask --quiet-fail --jobs=2"
alias unmerge="sudo \emerge --alert --ask --depclean"
# -AatuUd == --alert --ask --update --changed-use --deep --tree
alias sys-upd="sudo \emerge -AatuUD --with-bdeps=y --jobs=3 --quiet-fail \
	--keep-going @system; bell"
alias wld-upd="sudo \emerge -AatuUD --with-bdeps=y --jobs=3 --quiet-fail \
	--keep-going @world; bell"
alias rage-upd="sudo \emerge --alert --ask --emptytree --jobs=3 --quiet-fail \
	--keepgoing @world; bell"
alias full-upd="sys-upd && wld-upd && emerge @preserved-rebuild && unmerge && bell"

alias bell="echo '\a'"
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

# alias -g L="| less"
# alias -g G="| grep"
# alias -s pdf="mupdf"
# alias -s {txt,c,h,scm,tex}="vi"
# alias -s mp4="mpv"}}}
