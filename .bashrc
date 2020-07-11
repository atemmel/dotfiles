#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

(cat ~/.cache/wal/sequences &)

shopt -s autocd

alias v='nvim'
alias c='clear'
alias ll='ls -lh'
alias la='ls -lha'
alias gs='git status'
alias pls='sudo'
alias here='pwd | xclip -selection clipboard'
alias go-release='go build -ldflags "-s -w"'
alias go-release-win='env GOOS=windows GOARCH=amd64 go build -ldflags="-s -w"'
alias go-release-mac='env GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w"'

export PATH=$PATH:~/.bin/
export PATH=$PATH:~/go/bin/
export PS1='[\W]$ '
export BROWSER=firefox
export EDITOR=nvim
export TERM=xterm-256color

eval "$(pyenv init -)"
