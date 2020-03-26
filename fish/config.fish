source /usr/local/share/chruby/chruby.fish
source /usr/local/share/chruby/auto.fish

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/go/bin" $fish_user_paths

starship init fish | source
