# Shaine's Dotfiles

## Installation

- Install homesick, symlink dotfiles
- Install homebrew
`$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
- Install homebrew packages ([info](http://blog.gypsydave5.com/2015/10/16/homebrew-backup/))
`$ cat ~/.homebrew-packages | xargs brew install`
- Set correct emaill address in .gitconfig for env

## Environment-Specific Configs

```
export SETUP_ENV = (macos|ubuntu) # Pick one
ln -s ~/.homesick/dotfiles/home/.gitconfig.local.${SETUP_ENV} ~/.gitconfig.local
ln -s ~/.homesick/dotfiles/home/.tmux.conf.local.${SETUP_ENV} ~/.tmux.conf.local
```
