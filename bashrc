# -*- mode: sh -*-

export PATH=$HOME/bin:$PATH

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

function current-git-branch {
  branch="$(/usr/bin/git rev-parse --abbrev-ref HEAD 2>/dev/null)"

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

export PS1="\w git:\$(current-git-branch) » "

if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

alias git="hub"

for f in path completion; do
  fqp="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/${f}.bash.inc"
  test -f $fqp && source $fqp
done
