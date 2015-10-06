# -*- mode: sh -*-

export PATH=$HOME/bin:$PATH

export PATH=$PATH:~/pkg/bin:~/pkg/sbin
export MANPATH=$MANPATH:~/pkg/man

if [ -f $HOME/.the-setup/env.sh ]; then
  source $HOME/.the-setup/env.sh 
fi

export PATH=/usr/local/packer:$PATH

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

export GOPATH=$HOME
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

alias emacs="open -a /Applications/Emacs.app $@"
alias git="hub"

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

# Wrap ssh commmand to allow smart pane behavior in tmux.
#
# Lifted from https://github.com/moonboots/tmux-ssh/blob/master/tmux-sshrc
#
# After opening a tmux window and ssh-ing into another server, new panes will
# open already ssh-ed to the server.
function ssh() {
  if [ -n "$TMUX" ]; then
    window_name=$(tmux display-message -p '#W')
    tmux rename-window $1
    /usr/bin/ssh $*
    tmux rename-window $window_name
  else
    /usr/bin/ssh $*
  fi
}

test -f ~/.secrets.sh && source ~/.secrets.sh

export PS1="\w ruby:\$(current-ruby) git:\$(current-git-branch) » "
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

function chefdk() {
  eval "$(chef shell-init $(basename ${SHELL}))"
}

# Evaluate system PATH
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

if [ -x /usr/local/bin/boot2docker ]; then
    eval "$(boot2docker shellinit 2>/dev/null)"
fi

for f in /Users/wfarr/.secrets/*.sh; do
  source $f
done
