#!/bin/sh
export VISUAL=nvim
export EDITOR=$visual
#export TERMCMD=urxvt
export TERMCMD=alacritty
export BROWSER=firefox

systemctl --user import-environment DISPLAY
xset +fp ~/.local/share/fonts &

#compton &
~/.fehbg
wal -R -n
unclutter --timeout 1 --ignore-scrolling &
flameshot &
headsetcontrol -s 80

sxhkd -c ~/.config/binds.i3 &
~/.config/polybar/launch.sh

exec i3
