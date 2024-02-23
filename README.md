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


