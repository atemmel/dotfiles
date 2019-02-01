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
alias ll='ls -l'
alias la='ls -la'
alias miun='sftp adte1700@minafiler.miun.se'

export PATH=$PATH:~/.bin/
export PS1='[\W]$ '
export BROWSER=firefox

eval "$(pyenv init -)"
