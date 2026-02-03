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

# Load directory-specific configurations
# This hook triggers automatically when PWD changes
function __fish_on_pwd_change --on-variable PWD
    _load_directory_specific
end

# Load directory-specific configs on initial shell startup
_load_directory_specific

thefuck --alias | source

# Set up carapace for autocompletion
set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
carapace _carapace | source

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/hananavramovich/.lmstudio/bin
# End of LM Studio CLI section


# Created by `pipx` on 2025-06-12 12:03:27
set PATH $PATH /Users/hananavramovich/.local/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hananavramovich/google-cloud-sdk/path.fish.inc' ]; . '/Users/hananavramovich/google-cloud-sdk/path.fish.inc'; end

# Added by Antigravity
fish_add_path /Users/hananavramovich/.antigravity/antigravity/bin
