#!/bin/sh

die () {
	exit 1
}

is_wsl () {
	[ -e "/mnt/c" ]
}

shared_install () {
	sudo pacman -S $(< packages.txt)
	ln -rsf bin ~/bin
	ln -rsf .bashrc ~/.bashrc
	ln -rsf .config ~/.config
}

posix_install () {
	ln -rsf .bash_profile ~/.bash_profile
}

wsl_install () {
	local KEYS_URL="https://github.com/atemmel/keys/releases/download/0.2/keys.zip"
	local NEOVIDE_URL="https://github.com/neovide/neovide/releases/latest/download/neovide.exe.zip"
	local TMENU_URL="https://github.com/atemmel/tmenu/releases/download/0.2.1/tmenu.zip"

	local WIN_BIN="/mnt/c/bin"
	local WIN_CONF="/mnt/c/config"

	mkdir -p $WIN_BIN || die
	mkdir -p $WIN_CONF || die

	cp wsl/cconfig/* $WIN_CONF

	curl $NEOVIDE_URL -L -o "$WIN_BIN/neovide.zip" || die
	curl $KEYS_URL -L -o "$WIN_BIN/keys.zip" || die
	curl $TMENU_URL -L -o "$WIN_BIN/tmenu.zip" || die

	unzip -o "$WIN_BIN/neovide.zip" -d "$WIN_BIN/" || die
	unzip -o "$WIN_BIN/keys.zip" -d "$WIN_BIN/" || die
	unzip -o "$WIN_BIN/tmenu.zip" -d "$WIN_BIN/" || die

	powershell.exe 'Set-ExecutionPolicy Unrestricted -Scope CurrentUser'
	powershell.exe -File wsl/setup.ps1

	rm $WIN_BIN/*.zip
	chmod +x $WIN_BIN/*

}

shared_install

if is_wsl ; then
	wsl_install
else
	posix_install
fi
