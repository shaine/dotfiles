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
alias vi="nvim"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules --ignore .vim/plugged --ignore dist --ignore reports --ignore tmp --ignore docs --ignore .cache -g ""'

GRC=`which grc`
if [[ $? -eq 0 ]] && [ "$TERM" != dumb ]
then
    alias colourify="grc -es --colour=auto"
    alias configure="colourify ./configure"
    alias diff="colourify diff"
    alias make="colourify make"
    alias gcc="colourify gcc"
    alias g++="colourify g++"
    alias as="colourify as"
    alias gas="colourify gas"
    alias ld="colourify ld"
    alias netstat="colourify netstat"
    alias ping="colourify ping"
    alias traceroute="colourify /usr/sbin/traceroute"
    alias tail="colourify tail"
    alias head="colourify head"
fi

eval "$(thefuck --alias)"
alias fact="elinks -dump randomfunfacts.com | sed -n '/^| /p' | tr -d \|"
alias gitignored="git ls-files -v | grep \"^[a-z]\""
alias ls="ls -F"
alias ll="ls -alhF"
alias lol="fortune | cowthink | lolcat"
alias phperrors="tail -f /var/log/apache2/error_log"
alias tmux="tmux -2 -u"
alias tmuxcopy="tmux show-buffer | tr -d '\n' | pbcopy"
alias "tmux ns"="tmux new-session -s "
alias k=kubectl
alias vpn="/opt/cisco/anyconnect/bin/vpn"
alias vpnui="/opt/cisco/anyconnect/bin/vpnui"

function gitwatch() {
    watch -c -n 1 "figlet `basename $PWD`; echo ''; git branch; echo ''; git st"
}
function restartcoreaudio() {
    sudo kill -9 `ps ax|grep 'coreaudio[a-z]' |awk '{print $1}'`
}
function tmuxcolors() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
  done
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

export LS_OPTIONS="--color=auto"
export CLICOLOR="Yes"
export LSCOLORS="exgxfxfxcxdxdxhbadbxbx"
export SVN_EDITOR="vim"
export EDITOR="vim"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

unset RUBYOPT

function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ command}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-keymap-select

bindkey -v
bindkey -s "^[[O" ''
bindkey -s "^[[I" ''

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P003353f" #black
    echo -en "\e]P8032930" #darkgrey
    echo -en "\e]P1dc322f" #darkred
    echo -en "\e]P9cb4b16" #red
    echo -en "\e]P2859900" #darkgreen
    echo -en "\e]PA586e75" #green
    echo -en "\e]P3b58900" #brown
    echo -en "\e]PB657b83" #yellow
    echo -en "\e]P4268bd2" #darkblue
    echo -en "\e]PC839496" #blue
    echo -en "\e]P5d33682" #darkmagenta
    echo -en "\e]PD6c71c4" #magenta
    echo -en "\e]P62aa198" #darkcyan
    echo -en "\e]PE93a1a1" #cyan
    echo -en "\e]P7eee8d5" #lightgrey
    echo -en "\e]PFfdf6e3" #white
    clear #for background artifacting
fi

cd .

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

tictoc () {
    infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > ~/$TERM.ti
    tic ~/$TERM.ti
}

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

if [ "$DESKTOP_SESSION" = "i3" ]; then
  (cat ~/.cache/wal/sequences &)
  export $(gnome-keyring-daemon -s)
  alias settings="env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"
fi
