# Set the emoji width for iTerm
set -g fish_emoji_width 2

# Hide the fish greeting
set fish_greeting ""


if uname -m | grep -q "arm64" >/dev/null
  set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths
  set -g fish_user_paths "/opt/homebrew/sbin" $fish_user_paths
else
  set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
end

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/go/bin" $fish_user_paths
set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

alias vim=nvim

set -x EDITOR "nvim"

starship init fish | source
