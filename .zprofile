if [[ -z $DISPLAY ]] && [[ "$(tty)" == '/dev/tty1' ]]; then
	exec startx ~/.xinitrc i3
fi
