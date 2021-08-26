#!/bin/sh
targetresolution="1920x1080"
#targetresolution="1280x720"

choice=$(echo -e "left\nright\ntop\nmirror" | rofi -dmenu -i -p "Use external monitor as")
[ -z "$choice" ] && exit 0

case $choice in
	left) xrandr --output HDMI2 --mode "$targetresolution" --left-of eDP1;;
	right) xrandr --output HDMI2 --mode "$targetresolution" --right-of eDP1;;
	top) xrandr --output HDMI2 --mode "$targetresolution" --above eDP1;;
	mirror) xrandr --fb "$targetresolution" --output eDP1 --mode 1600x900 --scale-from "$targetresolution" --output HDMI2 --mode "$targetresolution" --scale 1x1 --same-as eDP1
;;
esac
