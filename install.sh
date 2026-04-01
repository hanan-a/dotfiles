#!/usr/bin/env bash
set -euo pipefail

SCRIPT_A_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_A_PATH")

if [ "$(pwd)" != "$SCRIPT_DIR" ]; then
  echo "Error: Please run this script from the dotfiles directory" >&2
  exit 1
fi

OS="$(uname -s)"

echo "Dotfiles installation running on ${OS}..."

# --- OS-specific package installation ---
case "$OS" in
  Darwin)
    echo "Installing Homebrew packages..."
    xargs brew install < ./homebrew/leaves.txt

    echo "Installing Homebrew font casks..."
    brew tap homebrew/cask-fonts
    if ! brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1; then
      brew install --cask font-jetbrains-mono-nerd-font
    else
      echo "font-jetbrains-mono-nerd-font is already installed."
    fi
    FISH_PATH="/opt/homebrew/bin/fish"
    ;;
  Linux)
    echo "Running apt installer..."
    bash ./apt/install.sh

    echo "Installing JetBrainsMono Nerd Font..."
    mkdir -p ~/.local/share/fonts
    curl -fLo ~/.local/share/fonts/JetBrainsMonoNerdFont.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip -o ~/.local/share/fonts/JetBrainsMonoNerdFont.zip -d ~/.local/share/fonts/
    rm ~/.local/share/fonts/JetBrainsMonoNerdFont.zip
    fc-cache -f -v

    FISH_PATH="/usr/bin/fish"
    ;;
  *)
    echo "Error: Unsupported OS '$OS'" >&2
    exit 1
    ;;
esac

# --- Common setup ---

if ! [ -x "$(command -v stow)" ]; then
  echo "Error: stow is not installed." >&2
  exit 1
fi

echo "Stowing dotfiles..."
stow -vt ~ . zsh
stow -vt ~/.config .config
stow -vt ~ .cursor

echo "Setting Fish shell as default shell..."
if ! grep -qF "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$FISH_PATH" ]; then
  echo "Changing default shell to fish..."
  chsh -s "$FISH_PATH"
else
  echo "Fish is already the default shell."
fi

echo "Installing Fisher..."
if ! "$FISH_PATH" -c 'type -q fisher'; then
  "$FISH_PATH" -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
else
  echo "Fisher is already installed."
fi

echo "Installing nvm.fish via Fisher..."
"$FISH_PATH" -c 'fisher install jorgebucaran/nvm.fish'
echo "Setting NVM default version to 18..."
"$FISH_PATH" -c 'set --universal nvm_default_version 18'
echo "Installing Node 18 via nvm..."
"$FISH_PATH" -c 'nvm install 18'

if [ "$OS" = "Linux" ]; then
  echo "Resetting macOS-specific fish universal variables..."
  "$FISH_PATH" -c 'set --universal fish_user_paths'
fi

echo "Dotfiles installation complete. Enjoy!"
