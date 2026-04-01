#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Adding PPAs..."
sudo add-apt-repository -y ppa:fish-shell/release-4
sudo add-apt-repository -y ppa:neovim-ppa/unstable

echo "==> Updating apt cache..."
sudo apt update

echo "==> Installing apt packages from packages.txt..."
xargs -a "$SCRIPT_DIR/packages.txt" sudo apt install -y

echo "==> Installing neovim (from PPA)..."
sudo apt install -y neovim

echo "==> Installing eza (official deb repo)..."
sudo mkdir -p /etc/apt/keyrings
TMP_KEYRING="$(mktemp)"
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | gpg --dearmor > "$TMP_KEYRING"
sudo install -m 644 "$TMP_KEYRING" /etc/apt/keyrings/gierens.gpg
rm -f "$TMP_KEYRING"
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg
sudo apt update
sudo apt install -y eza

echo "==> Upgrading fzf from GitHub (apt ships an outdated version)..."
FZF_VERSION=$(curl -sSL "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sSLo /tmp/fzf.tar.gz "https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar -xzf /tmp/fzf.tar.gz -C /tmp fzf
sudo install /tmp/fzf /usr/local/bin/fzf
rm /tmp/fzf.tar.gz /tmp/fzf

echo "==> Installing starship..."
if ! command -v starship &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "==> Installing zoxide..."
if ! command -v zoxide &>/dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

echo "==> Installing Go..."
if ! command -v go &>/dev/null; then
  GO_VERSION=$(curl -sSL 'https://go.dev/VERSION?m=text' | head -1)
  curl -sSL "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz" -o /tmp/go.tar.gz
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf /tmp/go.tar.gz
  rm /tmp/go.tar.gz
  export PATH=$PATH:/usr/local/go/bin
fi

echo "==> Installing lazygit..."
if ! command -v lazygit &>/dev/null; then
  LAZYGIT_VERSION=$(curl -sSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -sSLo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar -xzf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit /usr/local/bin/lazygit
  rm /tmp/lazygit.tar.gz /tmp/lazygit
fi

echo "==> Installing lazydocker..."
if ! command -v lazydocker &>/dev/null; then
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

echo "==> Installing yazi..."
if ! command -v yazi &>/dev/null; then
  YAZI_VERSION=$(curl -sSL "https://api.github.com/repos/sxyazi/yazi/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -sSLo /tmp/yazi.zip "https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip"
  unzip -o /tmp/yazi.zip -d /tmp/yazi
  sudo install /tmp/yazi/yazi-x86_64-unknown-linux-gnu/yazi /usr/local/bin/yazi
  rm -rf /tmp/yazi.zip /tmp/yazi
fi

echo "==> Installing lf..."
if ! command -v lf &>/dev/null; then
  LF_VERSION=$(curl -sSL "https://api.github.com/repos/gokcehan/lf/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
  curl -sSLo /tmp/lf.tar.gz "https://github.com/gokcehan/lf/releases/latest/download/lf-linux-amd64.tar.gz"
  tar -xzf /tmp/lf.tar.gz -C /tmp
  sudo install /tmp/lf /usr/local/bin/lf
  rm /tmp/lf.tar.gz /tmp/lf
fi

echo "==> Installing glow..."
if ! command -v glow &>/dev/null; then
  go install github.com/charmbracelet/glow@latest
fi

echo "==> Installing carapace..."
if ! command -v carapace &>/dev/null; then
  CARAPACE_VERSION=$(curl -sSL "https://api.github.com/repos/carapace-sh/carapace-bin/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -sSLo /tmp/carapace.tar.gz "https://github.com/carapace-sh/carapace-bin/releases/download/v${CARAPACE_VERSION}/carapace-bin_${CARAPACE_VERSION}_linux_amd64.tar.gz"
  tar -xzf /tmp/carapace.tar.gz -C /tmp
  sudo install /tmp/carapace /usr/local/bin/carapace
  rm /tmp/carapace.tar.gz /tmp/carapace
fi

echo "==> Installing pyenv..."
if ! command -v pyenv &>/dev/null; then
  curl https://pyenv.run | bash
fi

echo "==> Installing thefuck via pipx (apt version is broken on Python 3.12+)..."
if ! command -v thefuck &>/dev/null; then
  pipx install thefuck
fi

echo "==> Installing docker-compose plugin..."
sudo apt install -y docker-compose-plugin 2>/dev/null || echo "docker-compose-plugin not available (Docker may not be installed)"

echo "==> Installing ghostty..."
if ! command -v ghostty &>/dev/null; then
  sudo snap install ghostty --classic 2>/dev/null || echo "Snap not available or ghostty not found — install ghostty manually"
fi

echo "==> Installing alacritty..."
if ! command -v alacritty &>/dev/null; then
  sudo add-apt-repository -y ppa:aslatter/ppa 2>/dev/null && sudo apt install -y alacritty 2>/dev/null || echo "Alacritty PPA unavailable — install manually or via cargo"
fi

echo "==> Creating compatibility symlinks..."
mkdir -p "$HOME/.local/bin"
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
fi
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

echo "==> apt installation complete!"
