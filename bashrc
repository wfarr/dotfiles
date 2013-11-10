# -*- mode: sh -*-

export PATH=$HOME/bin:$PATH

if [ -d /opt/boxen ]; then
  source /opt/boxen/env.sh
fi

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend

PIN="\[\033[G\]"
GREY="\[\e[0;33m\]"
RED="\[\e[1;31m\]"
RESET="\[\e[m\]"

export GOPATH=~/gocode

alias emacs="open -a /Applications/Emacs.app $@"

function current-ruby {
  if [ -z "$RUBY_ROOT" ]; then
    echo "system"
  else
    echo "${RUBY_ROOT##*/}"
  fi
}

export PS1="\w\ » "
