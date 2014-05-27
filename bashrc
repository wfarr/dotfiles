# -*- mode: sh -*-

export PATH=$HOME/bin:$PATH

export PATH=$PATH:~/pkg/bin:~/pkg/sbin
export MANPATH=$MANPATH:~/pkg/man

#if [ -d /opt/boxen ]; then
#  source /opt/boxen/env.sh
#fi

for script in $(find ~/.do-setup/env.d -type f); do
  source $script
done

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend

PIN="\[\033[G\]"
GREEN="\[\e[0;32m\]"
GREY="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
CYAN="\[\e[0;36m\]"
RED="\[\e[1;31m\]"
RESET="\[\e[m\]"

export PATH=/usr/texbin:$PATH

#export GOROOT=~/go
#export GOPATH=~/gocode
#export PATH=~/gocode/bin:~/go/bin:$PATH

alias emacs="open -a /Applications/Emacs.app $@"

function current-git-branch {
  branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"

  if [ -n "$branch" ]; then
    echo "${branch}"
  else
    echo "(no branch)"
  fi
}

function synced-git-branch {
  if git diff --exit-code origin/$(current-git-branch) && git diff --exit-code origin/master; then
    return 0
  else
    return 1
  fi
}

source ~/.secrets.sh

export PS1="\w ruby:\$(current-ruby) git:\$(current-git-branch) » "
