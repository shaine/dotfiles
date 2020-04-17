# Path to your oh-my-zsh configuration.
ZSH_CUSTOM=$HOME/.omz-custom
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode brew zsh-syntax-highlighting zsh-autosuggestions)

[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local ZSH config if it exists
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/.mix/escripts:$HOMEPY/bin:/usr/local/lib/python2.7/site-packages:/usr/local/bin:$HOME/.bin:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin:$HOME/.local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

alias vim="nvim"
export FZF_DEFAULT_COMMAND='ag --follow --hidden --ignore .git --ignore node_modules --ignore .vim/plugged --ignore dist --ignore reports --ignore tmp --ignore docs --ignore .cache -g ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

eval "$(thefuck --alias)"
alias tmux="tmux -2 -u"
alias k=kubectl

function gitwatch() {
    watch -c -n 1 "figlet `basename $PWD`; echo ''; git branch; echo ''; git st"
}
function restartcoreaudio() {
    sudo kill -9 `ps ax|grep 'coreaudio[a-z]' |awk '{print $1}'`
}

tm () { if [[ -z $* ]]; then tmux ls; else tmux attach-session -d -t $* || tmux new-session -s $*; fi }
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

export EDITOR="vim"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ command}/(main|viins)/}"
    zle reset-prompt
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

export GOPATH="$HOME/go"
export PATH="$HOME/.rbenv/bin:$HOME/.yarn/bin:$GOPATH/bin:$PATH"

eval "$(rbenv init -)"
mkdir -p ~/.git/safe && export PATH="~/.git/safe/../../bin:$PATH"

# Enable IEx history
export ERL_AFLAGS="-kernel shell_history enabled"
