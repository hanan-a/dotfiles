export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export EDITOR="nvim"

# Source private configurations if the file exists
set private_config_file ~/.local/share/fish/private_config.fish
if test -f $private_config_file
    source $private_config_file
end

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



# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/hananavramovich/.lmstudio/bin
# End of LM Studio CLI section

