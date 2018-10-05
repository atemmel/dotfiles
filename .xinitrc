#! /bin/bash
export VISUAL=nvim
export EDITOR=$visual
export TERMCMD=urxvt

systemctl --user import-environment DISPLAY
xset +fp ~/.local/share/fonts &

exec i3
