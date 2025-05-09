export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export EDITOR="nvim"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

# Set up fzf key bindings
fzf --fish | source

fish_vi_key_bindings
custom_functions
starship init fish | source
zoxide init fish | source

thefuck --alias | source
