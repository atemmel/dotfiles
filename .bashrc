#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [ -f ~/.cache/wal/sequences ] ; then
	(cat ~/.cache/wal/sequences &)
	~/bin/walfix
fi

if [ -e /mnt/c ] ; then
	alias vh='(neovide.exe --wsl . &)'
	export LIBGL_ALWAYS_INDIRECT=1
else
	alias vh='nvim .'
fi

export HISTSIZE=-1
export HISTFILESIZE=-1

shopt -s autocd
shopt -s globstar

alias v='nvim'
alias c='clear'
alias ll='ls -lhrt'
alias la='ls -lhrtA'
alias gs='git status'
alias gp='git pull'
alias gc='git checkout'
alias git-prune='git remote prune origin'
alias pls='sudo'
alias go-release='go build -ldflags "-s -w"'
alias go-release-win='env GOOS=windows GOARCH=amd64 go build -ldflags="-s -w"'
alias go-release-mac='env GOOS=darwin GOARCH=arm64 go build -ldflags="-s -w"'
alias go-release-mac-old='env GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w"'
alias kitty='GLFW_IM_MODULE=none kitty'
alias yank='history | tail -2 | head -1 | sed "s/\ \ [0-9]*\ \ \(.*\)/\1/" | xclip -selection clipboard'

export PATH=$PATH:~/bin/
export PATH=$PATH:~/go/bin/
export PATH=$PATH:/mnt/c/bin
export PS1='[\W]$ '
export BROWSER=firefox
export EDITOR=nvim
export TERM=xterm-256color

if command -v pyenv &> /dev/null ; then
	eval "$(pyenv init -)"
fi

if command -v kubectl &> /dev/null
then
	source <(kubectl completion bash)
fi

if [[ -e ~/.bashrc-local ]] ; then
	source ~/.bashrc-local
fi

if [[ -e ~/bin-local ]] ; then
    PATH=$PATH./bin-local
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

cherry
if [ $? -eq 0 ] ; then
    echo Exiting cherry, you are now in bash
    #exit 0
fi
