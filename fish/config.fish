# Set the emoji width for iTerm
set -g fish_emoji_width 2

# Hide the fish greeting
set fish_greeting ""

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/go/bin" $fish_user_paths

alias vim=nvim

starship init fish | source
