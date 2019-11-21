source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

alias h="heroku"
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths