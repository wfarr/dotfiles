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

export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_FREE_MIN=500000
export RUBY_HEAP_MIN_SLOTS=40000

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

if [ "${TERM}" != "dumb" ]; then
  export CLICOLOR="cons25"
  export TERM=screen-256color

  PS1="${PIN}${GREY}\w\$(__git_ps1 "[%s]") (\$?) »${RESET} "
else
  PS1="\w\$(__git_ps1 "[%s]") (\$?) » "
fi



