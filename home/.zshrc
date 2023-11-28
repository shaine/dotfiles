ZSH_CUSTOM=$HOME/.omz-custom
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="squidtree"
export ZSH=$HOME/.oh-my-zsh

XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/home/shaine/.local/share/flatpak/exports/share:$XDG_DATA_DIRS

# For psql
export PAGER='nvim -c "set syntax=dbout" -R -'

COMPLETION_WAITING_DOTS="true"

# Plugins I want to learn: 1password autoenv
plugins=(git vi-mode zsh-syntax-highlighting zsh-autosuggestions)

[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local ZSH config if it exists

source $ZSH/oh-my-zsh.sh

export PATH=$HOME/.bin:$HOME/.local/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH

export FZF_DEFAULT_COMMAND='ag --follow --hidden -g ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias tmux="tmux -2 -u"
alias k=kubectl
alias vim="nvim"
export EDITOR="vim"

# Fix urxvt over SSH brokeness
export TERM='xterm-256color'

# Fix other-writeable directory colors
export LS_COLORS=$LS_COLORS:'ow=1;36'
zstyle ':completion:*' list-colors 'ow=1;36'

tm() {
  if [[ -z $* ]]; then
    tmux ls;
  else
    tmux new-session -d -s $* > /dev/null
    tmux attach-session -d -t $*
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
export NODE_OPTIONS=--openssl-legacy-provider

# Enable IEx history
export ERL_AFLAGS="-kernel shell_history enabled"
