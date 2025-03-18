ZSH_CUSTOM=$HOME/.omz-custom
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="squidtree"
export ZSH=$HOME/.oh-my-zsh

XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/home/shaine/.local/share/flatpak/exports/share:$XDG_DATA_DIRS

# For psql
export PAGER='nvim -c "set syntax=dbout" -R -'
# For manpages
export MANPAGER='nvim +Man!'

COMPLETION_WAITING_DOTS="true"

# Plugins I want to learn: 1password autoenv
# direnv: sudo apt install direnv
plugins=(git direnv asdf vi-mode zsh-syntax-highlighting zsh-autosuggestions)

[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local ZSH config if it exists

source $ZSH/oh-my-zsh.sh

export PATH=$HOME/.bin:$HOME/.local/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/go/bin:/$HOME/.go/bin:$PATH

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

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# rubby
[[ -s "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc" ]] && source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# golang
export GOPATH=$HOME/.go
export GOBIN=$HOME/.go/bin

# npm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
