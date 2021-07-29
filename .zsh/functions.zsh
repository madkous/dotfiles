# FUNCTIONS
du-func() { \du -achd 1 $@ | sort }

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

