# My Dotfiles

This repository contains my personal terminal configuration files and setup script for quickly bootstrapping a clean and modern command-line environment.

It includes:

- **Zsh** configuration (`.zshrc` + `.zsh/`)
- **Tmux** configuration (`.tmux.conf`)
- A setup script that installs:
  - `tmux`, `fzf`, `zoxide`, `exa`, `bat`, `chisel`, etc.
  - Rust and Cargo (if not already installed)
  - Modern CLI tools via Cargo

---

## Usage
### Prerequisites
Before using this repo, make sure you used __zsh as the default login shell__.
1. Check if zsh is installed.
```bash
command -v zsh || (sudo apt update && sudo apt install -y zsh)
```
2. Check if zsh is set as the default shell.
```bash
echo $SHELL
```
If the output is not something like `/usr/bin/zsh`, set Zsh as your default shell:
```bash
chsh -s $(which zsh)
```
Then logout and log back in (or restart the terminal) to apply the change.

### Installation
```bash
git clone https://github.com/RyanYiwei/dotfiles.git
cd dotfiles
sudo sh -x setup.sh
source $HOME/.zshrc
```
