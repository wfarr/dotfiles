# -*- mode: sh -*-

export PATH=$HOME/bin:$PATH

if [ -d /opt/boxen ]; then
  source /opt/boxen/env.sh
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

exit_status () {
  if [ $? -ne 0 ]; then
    echo $?
  fi
}

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend

history() {
  _bash_history_sync
  builtin history "$@"
}

_bash_history_sync() {
  builtin history -a
  HISTFILESIZE=$HISTSIZE
  builtin history -c
  builtin history -r
}

PROMPT_COMMAND=_bash_history_sync

PIN="\[\033[G\]"
GREY="\[\e[0;33m\]"
RED="\[\e[1;31m\]"
RESET="\[\e[m\]"

PS1="\w\$(__git_ps1 "[%s]") (\$?) » "
