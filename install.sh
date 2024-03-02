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

echo "Stowing dotfiles..."
stow -vt ~ .config zsh 
