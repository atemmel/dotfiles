#
# ~/.bash_profile
#

[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc

# autostart systemd default session on tty1
if [[ -z $DISPLAY ]] && [[ "$(tty)" == '/dev/tty1' ]]; then
	#wm=(i3 pad)
	#choice=

	#while true 
	#do 
		#printf "1) i3\n2) pad\n"
		#read
		#case "$REPLY" in
			#"1") 
				#choice=i3
				#break;;
			#"2")
				#choice=wm
				#break;;
			#*) ;;
		#esac
	#done

	#exec startx "$HOME/.xinitrc i3"
	exec startx
fi
