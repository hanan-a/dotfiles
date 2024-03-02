#!/usr/bin/env bash

SCRIPT_A_PATH=$(readlink -f $0)
SCRIPT_DIR=$(dirname $SCRIPT_A_PATH)

# stop if PWD is not the same as the script location
if [ "$(pwd)" != "$SCRIPT_DIR" ]; then
  echo "Error: Please run this script from the dotfiles directory" >&2
    exit 1
fi

# Stop if stow is not installed
if ! [ -x "$(command -v stow)" ]; then
  echo "Error: stow is not installed." >&2
  exit 1
fi

echo "Dotfiles installation running..."

echo "Installing Homebrew packages..."
xargs brew install < ./homebrew/leaves.txt

echo "Setting FishShell as default shell..."
# if fish is already in /etc/shells, don't add it again
if ! grep -q "/usr/local/bin/fish" /etc/shells; then
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
fi

# if fish is not the default shell, change it
if [ "$SHELL" != "/opt/homebrew/bin/fish" ]; then
  echo "Changing default shell to fish..."
  chsh -s /usr/local/bin/fish
else
  echo "Fish is already the default shell."
fi



echo "Stowing dotfiles..."
stow -vt ~ .config zsh 
