NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


alias cls='clear'

alias la='eza -a -l --icons'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/hananavramovich/.lmstudio/bin"
# End of LM Studio CLI section

