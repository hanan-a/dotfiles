# Dotfiles

# Installation (MacOS)
---


Install Homebrew packages
---
This command uses the `homebrew/leaves.txt` file to list the needed packages.

```shell
xargs brew install < ./homebrew/leaves.txt
```

## Symlink files into the `~` directory using __stow__:
---

Make sure to install [GNU stow](https://www.gnu.org/software/stow/).

```shell
brew install stow
```
Then symnlink the files to the home dir `~`

```shell
stow -vt ~ .
```

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


