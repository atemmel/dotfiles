alt + Return
	$TERMCMD 

alt + d
	rofi -show run

alt + Shift + d
	~/bin/docs

alt + y
	~/bin/playclip

alt + M
	$TERMCMD -e ncmpcpp

alt + f
	$TERMCMD -e spider

alt + p
	scrot

alt + shift + p
	~/bin/roms

alt + control + p
	flameshot gui

alt + control + h
	~/bin/headers

alt + x
	~/bin/shutdownmenu

alt + z
	sxcs --mag-filters circle --color-none -q

alt + c
	i3-msg "workspace 2; exec $BROWSER"

alt + control + e
	~/bin/emoji

alt + n
	~/bin/gonote-list

alt + shift + n
	~/bin/gonote-append

alt + s
	~/bin/skyrim-launch

alt + shift + s
	~/bin/skyrim-kill

alt + i
	i3lock-fancy

XF86MonBrightness{Up,Down}
	xbacklight {-inc,-dec} 2

alt + shift + e
	i3-msg exit

alt + m
	~/bin/monitors.sh

alt + o
	tmenu -dir ~/doc -command $HOME/bin/open-project project

alt + e
    neovide
