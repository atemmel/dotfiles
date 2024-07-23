#!/bin/sh

choice=$(echo -e "left\nright\ntop\nmirror\nrestore" | rofi -dmenu -i -p "Use external monitor as")
[ -z "$choice" ] && exit 0

line=$(xrandr | grep ' connected' | grep -v 'eDP-1')
targetmonitor=$(echo $line | cut -d " " -f1)
targetresolution=$(xrandr --query | grep  -A 1 -P '^(?!eDP-1).* connected' | grep -v 'connected' | sed -r 's/.* ([0-9]+x[0-9]+).*/\1/')

xrandr --output eDP-1 --transform none

case $choice in
	left) xrandr --output $targetmonitor --mode "$targetresolution" --left-of eDP-1;;
	right) xrandr --output $targetmonitor --mode "$targetresolution" --right-of eDP-1;;
	top) xrandr --output $targetmonitor --mode "$targetresolution" --above eDP-1;;
	restore) xrandr --output eDP-1 --transform none;;
	mirror) xrandr --fb "$targetresolution" --output eDP-1 --mode 1600x900 --scale-from "$targetresolution" --output $targetmonitor --mode "$targetresolution" --scale 1x1 --same-as eDP-1
;;
esac
