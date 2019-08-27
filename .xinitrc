#!/bin/sh
export VISUAL=nvim
export EDITOR=$visual
export TERMCMD=urxvt
export BROWSER=firefox

systemctl --user import-environment DISPLAY
xset +fp ~/.local/share/fonts &

compton &
mpd &
~/.fehbg &
wal -R -n &
~/.config/polybar/launch.sh &
unclutter --timeout 1 --ignore scrolling &
flameshot &
sxhkd -c ~/.config/sxhkdrc &

exec i3
