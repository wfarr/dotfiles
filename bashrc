# -*- mode: sh -*-

export PATH=$HOME/bin:$PATH

export PATH=$PATH:~/pkg/bin:~/pkg/sbin
export MANPATH=$MANPATH:~/pkg/man

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

function current-git-branch {
  branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"

  if [ -n "$branch" ]; then
    echo $branch
  else
    echo "not on a branch" >&2
    return 1
  fi
}

function synced-git-branch {
  if git diff --exit-code origin/$(current-git-branch) && git diff --exit-code origin/master; then
    return 0
  else
    return 1
  fi
}

export PS1="\w\ » "
