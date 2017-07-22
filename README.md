# Shaine's Dotfiles

## Installation

- Install neovim
- Install the_silver_searcher
- Install thefuck

## Environment-Specific Configs

```
export SETUP_ENV = (macos|ubuntu)
ln -s ~/.homesick/dotfiles/home/.gitconfig.local.${SETUP_ENV} ~/.gitconfig.local
ln -s ~/.homesick/dotfiles/home/.tmux.conf.local.${SETUP_ENV} ~/.tmux.conf.local
```
