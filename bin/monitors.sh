#!/bin/sh
targetresolution="1920x1080"
#targetresolution="1280x720"
#targetresolution="1600x900"
#targetresolution="2560x1440"
#targetresolution="3440x1440"

choice=$(echo -e "left\nright\ntop\nmirror\nrestore" | rofi -dmenu -i -p "Use external monitor as")
[ -z "$choice" ] && exit 0

case $choice in
	left) xrandr --output DP-1 --mode "$targetresolution" --left-of eDP-1;;
	right) xrandr --output DP-1 --mode "$targetresolution" --right-of eDP-1;;
	top) xrandr --output DP-1 --mode "$targetresolution" --above eDP-1;;
	restore) xrandr --output eDP-1 --transform none;;
	mirror) xrandr --fb "$targetresolution" --output eDP-1 --mode 1600x900 --scale-from "$targetresolution" --output HDMI-1 --mode "$targetresolution" --scale 1x1 --same-as eDP-1
;;
esac
