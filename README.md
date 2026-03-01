# Dotfiles

# Installation (MacOS)
---

Run the _install.sh_ file from within the _dotfiles_ directory.
It will install all Homebrew dependencies and symlink all needed files.

```shell
bash install.sh
```

---

Install Homebrew packages
---
This command uses the `homebrew/leaves.txt` file to list the needed packages.

```shell
xargs brew install < ./homebrew/leaves.txt
```

# Installation (Linux/Ubuntu)
---

Run the _install.sh_ file from within the _dotfiles_ directory.
It detects the OS automatically and runs the appropriate installer.

```shell
bash install.sh
```

The Linux installer will:
1. Add required PPAs (fish, neovim-unstable)
2. Install packages from `apt/packages.txt`
3. Install additional tools not available in default repos (starship, eza, lazygit, lazydocker, yazi, lf, glow, zoxide, carapace, pyenv, Go, ghostty, alacritty)
4. Create compatibility symlinks for `bat` → `batcat` and `fd` → `fdfind`

To run just the apt installer independently:

```shell
bash apt/install.sh
```

## Symlink files into the `~` directory using stow:

Make sure to install [GNU stow](https://www.gnu.org/software/stow/).

```shell
# macOS
brew install stow

# Ubuntu/Debian
sudo apt install stow
```
Then symlink the files to the home dir `~`

```shell
stow -vt ~ .
```

You can use the `--simulate`/`-n` option to simulate operations to view the results.

You might need to ignore the `.DS_Store` file by adding `--ignore=DS_Store`.

# Fish Shell
---

Install fish using the main installation or run:

```shell
# macOS
brew install fish

# Ubuntu
sudo add-apt-repository ppa:fish-shell/release-4
sudo apt update && sudo apt install fish
```

Set fish as the default shell:

1. Add the shell to /etc/shells with:

```shell
# macOS
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells

# Linux
echo /usr/bin/fish | sudo tee -a /etc/shells
```

2. Change your default shell with:

```shell
# macOS
chsh -s /opt/homebrew/bin/fish

# Linux
chsh -s /usr/bin/fish
```

## Installing NVM in Fish Shell

1. Install the [fisher](https://github.com/jorgebucaran/fisher) package manager if not yet installed.

```shell
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

2. Install nvm using fisher:

```shell
fisher install jorgebucaran/nvm.fish
```

3. Set nvm default node version by running the following command:

```shell
set --universal nvm_default_version 18
```

# Cursor MCP Configuration
---

The `.cursor/mcp.json` file configures Model Context Protocol (MCP) servers for Cursor. To keep sensitive tokens out of version control, we use a template-based approach.

## Setup

1. **Set the GitHub MCP token as an environment variable:**

   For Fish Shell (recommended for this setup):
   ```fish
   set -gx GITHUB_MCP_TOKEN "your_github_pat_token_here"
   ```
   
   Or add to `~/.local/share/fish/private_config.fish` (create if it doesn't exist):
   ```fish
   set -gx GITHUB_MCP_TOKEN "your_github_pat_token_here"
   ```

   For Bash/Zsh:
   ```shell
   export GITHUB_MCP_TOKEN="your_github_pat_token_here"
   ```

2. **Generate `mcp.json` from the template:**
   ```shell
   ~/.cursor/generate-mcp.sh
   ```

   Or if running from the dotfiles directory:
   ```shell
   .cursor/generate-mcp.sh
   ```

## Files

- `mcp.json.template` - Template file (safe to commit, contains `{{GITHUB_MCP_TOKEN}}` placeholder)
- `mcp.json` - Generated file (gitignored, contains actual token)
- `generate-mcp.sh` - Script to generate `mcp.json` from template

**Note:** The `mcp.json` file is gitignored to prevent committing sensitive tokens. Always generate it from the template using the script.
