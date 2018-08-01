#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

feh --bg-scale /home/kous/.wallpaper &

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

statusbar &
xbindkeys
unclutter -idle 2 -jitter 15 &
setxkbmap -option caps:escape &

#relaunch dwm
csum=$(sha1sum $(which dwm))
new_csum=""
while true
do
	if [ "$csum" != "$new_csum" ]
	then
		csum=$new_csum
		dwm
	else
		exit 0
	fi
	new_csum=$(sha1sum $(which dwm))
	sleep 0.5
done

