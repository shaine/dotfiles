# Shaine's Dotfiles

## Environment-Specific Configs

```
export SETUP_ENV = (macos|ubuntu)
ln -s ~/.homesick/dotfiles/home/.gitconfig.local.${SETUP_ENV} ~/.gitconfig.local
ln -s ~/.homesick/dotfiles/home/.tmux.conf.local.${SETUP_ENV} ~/.tmux.conf.local
```
