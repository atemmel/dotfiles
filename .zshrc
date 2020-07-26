# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/temmel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd notify
bindkey -v
# End of lines configured by zsh-newuser-install


alias ls='ls --color=auto'
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
export BROWSER=firefox
export EDITOR=nvim
export TERM=xterm-256color
export PROMPT='%(?.√.?%?) %1~ %# '

eval "$(pyenv init -)"
