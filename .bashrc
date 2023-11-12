#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [ -f ~/.cache/wal/sequences ]
then
	(cat ~/.cache/wal/sequences &)
	~/bin/walfix
fi

shopt -s autocd
shopt -s globstar

alias v='nvim'
alias c='clear'
alias ll='ls -lh'
alias la='ls -lha'
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

alias vh='(neovide.exe --wsl . &)'
alias rl='rocket launch'
alias rt='rocket test'

export MAVEN_OPTS='-Xms512m -Xmx2560m -Djavax.net.ssl.trustStore=/mnt/c/Bolagsverket/DevTools/cert/BolagsverketRootCA01_unix_java_truststore.jks -Djavax.net.ssl.trustStorePassword=password'
export CLASSPATH='~/.m2/repositories/'

export TNS_ADMIN=~/tnsnames

if command -v pyenv &> /dev/null
then
	eval "$(pyenv init -)"
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION


source /usr/share/nvm/init-nvm.sh
export NODE_EXTRA_CA_CERTS='/mnt/c/Bolagsverket/DevTools/cert/BolagsverketRootCA01.pem'

if command -v kubectl &> /dev/null
then
	source <(kubectl completion bash)
fi

if command -v route.exe &> /dev/null
then
	export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
fi
export LIBGL_ALWAYS_INDIRECT=1
