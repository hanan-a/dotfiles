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

## Symlink files into the `~` directory using stow:

Make sure to install [GNU stow](https://www.gnu.org/software/stow/).

```shell
brew install stow
```
Then symnlink the files to the home dir `~`

```shell
stow -vt ~ .
```

You can use the `--simulate`/`-n` option to simulate operations to view the results.

You might need to ignore the `.DS_Store` file by adding `--ignore=DS_Store`.

# Fish Shell
---

Install fish using the main installation or run:

```shell
brew install fish
```

Set fish as the default shell:

1. Add the shell to /etc/shells with:

```shell
echo /usr/local/bin/fish | sudo tee -a /etc/shells
```

2. Change your default shell with:

```shell
chsh -s /usr/local/bin/fish
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

The `.cursor/mcp.json` file configures Model Context Protocol (MCP) servers for Cursor.

## GitHub MCP Server

The GitHub MCP server uses Cursor's built-in GitHub Copilot authentication. **No token is required** - it automatically authenticates using your Cursor account's GitHub credentials.

The configuration is simply:
```json
"github": {
  "url": "https://api.githubcopilot.com/mcp/"
}
```

No Authorization header or environment variables are needed.

