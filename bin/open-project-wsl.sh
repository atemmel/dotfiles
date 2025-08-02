#!/bin/sh
[ -z $1 ] && echo "No path specified" && exit 1

path=$(wslpath $1)

cd $path
exec neovide.exe --maximized --multigrid --wsl $path
