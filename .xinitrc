#!/bin/sh
export VISUAL=nvim
export EDITOR=$VISUAL
export TERMCMD=ghostty
export BROWSER=firefox

systemctl --user import-environment DISPLAY
xset +fp ~/.local/share/fonts &

mpd &
~/.fehbg
wal -R -n

# Temporary
~/.bin/walfix
unclutter --timeout 1 --ignore-scrolling &
flameshot &
headsetcontrol -s 100

sxhkd -c ~/.config/binds.i3 &
#swhks &
#pkexec swhkd -c ~/.config/binds.i3 &
~/.config/polybar/launch.sh

exec i3
