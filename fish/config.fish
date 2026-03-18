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
set -g fish_user_paths "$HOME/.local/bin" $fish_user_paths
 

set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export VAGRANT_VM_CPUS=8
export VAGRANT_VM_MEMORY=16384
 
alias vim=nvim

set -x EDITOR "nvim"

starship init fish | source
rv shell init fish | source
# _rv_autoload_hook
rv shell completions fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
