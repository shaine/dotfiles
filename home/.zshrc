  # (cat ~/.cache/wal/sequences &)
  # clear
# fi

ZSH_CUSTOM=$HOME/.omz-custom
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="squidtree"
export ZSH=$HOME/.oh-my-zsh

export PAGER='nvim -c "set syntax=dbout" -R -'

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode brew zsh-syntax-highlighting zsh-autosuggestions)

[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local ZSH config if it exists

source $ZSH/oh-my-zsh.sh

export GO111MODULE=auto
export GOPATH=$HOME/go

export PATH=$HOME/.mix/escripts:$HOMEPY/bin:/usr/local/bin:$HOME/.bin:/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:$HOME/.rbenv/bin:/usr/local/go/bin:$GOPATH/bin:$PATH

export FZF_DEFAULT_COMMAND='ag --follow --ignore .fzf --ignore .dropbox-dist --ignore Pictures --ignore .kube --ignore Books --ignore Adium --ignore .npm --ignore .oh-my-zsh --ignore .minecraft --ignore .nvm --ignore .omz-custom --ignore minecraft --ignore .dropbox --ignore .proxyman --ignore .local --ignore .java --ignore Dropbox --ignore snap --ignore www --ignore Photos\ Library.photoslibrary --ignore ruby-advisory-db --ignore .mix --hidden --ignore .node-gyp --ignore Music --ignore Library --ignore .ivy2 --ignore .config/nvim/tmp --ignore .config/nvim/autoload --ignore .config/nvim/plugged --ignore .hex --ignore .rbenv --ignore .zoom --ignore .git --ignore node_modules --ignore .vim/plugged --ignore dist --ignore reports --ignore tmp --ignore docs --ignore .cache -g ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -x "$(command -v thefuck)" ]; then
  eval "$(thefuck --alias)"
fi
alias tmux="tmux -2 -u"
alias k=kubectl
alias vim="nvim"
export EDITOR="vim"

# Fix urxvt over SSH brokeness
export TERM='xterm-256color'

# Fix other-writeable directory colors
export LS_COLORS=$LS_COLORS:'ow=1;36'
zstyle ':completion:*' list-colors 'ow=1;36'

function gitwatch() {
    watch -c -t -n 1 "basename $PWD | head -c 7 | figlet; echo ''; git branch; echo ''; git st"
}
function restartcoreaudio() {
    sudo kill -9 `ps ax|grep 'coreaudio[a-z]' |awk '{print $1}'`
}

tm() {
  if [[ -z $* ]]; then
    tmux ls;
  else
    # tmux new-session -d -s side_top > /dev/null
    # tmux new-session -d -s side_middle > /dev/null
    # tmux new-session -d -s side_bottom > /dev/null
    tmux new-session -d -s $* > /dev/null

    # If the session is a "side" session, then don't bind connection triggers
    # if [[ $1 != side* ]]; then
      # change_command="SESSION=$1 ~/.tmux/change_session.sh"
      # hook_command="run '$change_command'"

      # tmux set-hook -t $1 client-attached $hook_command
      # tmux set-hook -t $1 client-session-changed $hook_command

      # eval $change_command
    # fi

    tmux attach-session -d -t $*
  fi
}

kssh() {
  bold=`tput bold`
  normal=`tput sgr0`

  if [ -z "$1" ]; then
    echo "You must supply a ${bold}NAME${normal} argument!"
    echo "\n  $ kssh <NAME>"
    return
  fi

  context=`kubectl config current-context`
  pod=`kubectl get pods | grep "^$1" | awk '{print $1}' | head -n 1`

  echo "Connecting to ${bold}$pod${normal} in ${bold}$context${normal}"

  kubectl exec -it --request-timeout=5s $pod bash
}

# function zle-keymap-select {
    # VIMODE="${${KEYMAP/vicmd/ command}/(main|viins)/}"
    # zle reset-prompt
# }

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

eval "$(rbenv init -)"

# Enable IEx history
export ERL_AFLAGS="-kernel shell_history enabled"

slugify() {
  echo "$*" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z
}

inbox_file() {
  filename=$(basename -- "$1")
  extension="${filename##*.}"
  filename="${filename%.*}"
  cp --no-preserve=mode,ownership $1 "$HOME/Documents/notes/$(strftime %Y%m%d-%H%M)-$(slugify $filename).$extension"
  rm $1
}

# Ensure SSH Agent is running
# if [ -f ~/.ssh/agent.env ] ; then
    # . ~/.ssh/agent.env > /dev/null
    # if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        # echo "Stale agent file found. Spawning a new agent. "
        # eval `ssh-agent | tee ~/.ssh/agent.env`
        # ssh-add
    # fi
# else
    # echo "Starting ssh-agent"
    # eval `ssh-agent | tee ~/.ssh/agent.env`
    # ssh-add
# fi

# Run external commands after startup
eval "$RUN"
