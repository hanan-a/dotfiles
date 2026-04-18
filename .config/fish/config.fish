export NVM_DIR="$HOME/.nvm"
if test -s "/opt/homebrew/opt/nvm/nvm.sh"
    \. "/opt/homebrew/opt/nvm/nvm.sh"
    test -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"; and \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else if test -s "$HOME/.nvm/nvm.sh"
    \. "$HOME/.nvm/nvm.sh"
    test -s "$HOME/.nvm/bash_completion"; and \. "$HOME/.nvm/bash_completion"
end

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

# Set up fzf key bindings (requires fzf 0.46+; older versions use the fzf.fish plugin)
fzf --fish 2>/dev/null | source

fish_vi_key_bindings
custom_functions
if type -q starship
    starship init fish | source
end
zoxide init fish | source

# Load directory-specific configurations
# This hook triggers automatically when PWD changes
function __fish_on_pwd_change --on-variable PWD
    _load_directory_specific
end

# Load directory-specific configs on initial shell startup
_load_directory_specific

if type -q thefuck
    thefuck --alias 2>/dev/null | source
end

# Set up carapace for autocompletion
if type -q carapace
    set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
    carapace _carapace fish | source
end

# LM Studio CLI
if test -d "$HOME/.lmstudio/bin"
    set -gx PATH $PATH $HOME/.lmstudio/bin
end

# pipx
if test -d "$HOME/.local/bin"
    set PATH $PATH $HOME/.local/bin
end

# Google Cloud SDK
if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    source "$HOME/google-cloud-sdk/path.fish.inc"
end

# Antigravity
if test -d "$HOME/.antigravity/antigravity/bin"
    fish_add_path $HOME/.antigravity/antigravity/bin
end

# Obsidian CLI
if test -d "/Applications/Obsidian.app/Contents/MacOS"
    fish_add_path /Applications/Obsidian.app/Contents/MacOS
end
