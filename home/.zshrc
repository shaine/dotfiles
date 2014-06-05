# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="pygmalion"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn vi-mode osx brew zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export HOMEPY=$HOME/Library/Python/2.7
export PATH=$HOMEPY/bin/:/usr/local/lib/python2.7/site-packages:/usr/local/bin:$HOME/.bin:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

# Powerline prompt
source $HOMEPY/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

GRC=`which grc`
if [[ $? -eq 0 ]] && [ "$TERM" != dumb ]
then
    alias colourify="$GRC -es --colour=auto"
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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local ZSH config if it exists

alias fact="elinks -dump randomfunfacts.com | sed -n '/^| /p' | tr -d \|"
alias gitignored="git ls-files -v | grep \"^[a-z]\""
alias ls="ls -GF"
alias ll="ls -alhGF"
alias lol="fortune | cowthink | lolcat"
alias phperrors="tail -f /var/log/apache2/error_log"
alias tmux="tmux -2 -u"
alias tmuxcopy="tmux show-buffer | tr -d '\n' | pbcopy"
alias "tmux ns"="tmux new-session -s "
alias "svnls"="svn ls '^/branches/m_www/feature/';
    svn ls '^/branches/m_www/update/';
    svn ls '^/branches/m_www/fix/';
    svn ls '^/branches/m_www/test/'"
function restartcoreaudio() {
    sudo kill -9 `ps ax|grep 'coreaudio[a-z]' |awk '{print $1}'`
}
function svnbranch() {
    svn copy "^/trunk/m_www" "^/branches/m_www/"$*
    svn switch "^/branches/m_www/"$*"/assets"
}
function svndelete() {
    svn delete "^/branches/m_www/"$* -m "Completed branch "$*
}
function svnswitch() {
    if [[ -z $* ]]
    then
        svn switch "^/trunk/m_www/assets"
    else
        svn switch "^/branches/m_www/"$*"/assets"
    fi
}
function svnmerge() {
    if [[ -z $* ]]
    then
        svn merge "^/trunk/m_www/assets"
    else
        svn merge --reintegrate "^/branches/m_www/"$*"/assets"
    fi
}
# Google search
function google() {
    query=""
    for this_query_term in $@
    do
        query="${query}${this_query_term}+"
    done
    url="https://encrypted.google.com/search?q=${query}"

    remote_addr=`who am i | awk -F\( '{print $2}' | sed 's/)//'`

    if [ -z "$remote_addr" ]; then
        open "$url"
    else
        links "$url"
    fi
}

function switchhosts {
    if [ $1 = "prod" ]
    then
        sudo sed "s/#*\([0-9]*\.[0-9]*\.[0-9]*\.\)\([0-9]*\)\(.* #switchable\)/#\1\2\3/g" /etc/hosts > /tmp/hosts.tmp && sudo mv /tmp/hosts.tmp /etc/hosts
    else
        sudo sed "s/#*\([0-9]*\.[0-9]*\.[0-9]*\.\)\([0-9]*\)\(.* #switchable\)/\1$1\3/g" /etc/hosts > /tmp/hosts.tmp && sudo mv /tmp/hosts.tmp /etc/hosts
    fi
}

# Nocorrects for ZSH
alias composer="nocorrect composer"

tm () { if [[ -z $* ]]; then tmux ls; else tmux attach-session -d -t $* || tmux new-session -s $*; fi }

export GREP_OPTIONS="--color=auto" GREP_COLOR="1;32"
export LS_OPTIONS="--color=auto"
export CLICOLOR="Yes"
export LSCOLORS="exgxfxfxcxdxdxhbadbxbx"
export SVN_EDITOR="vim"

unset RUBYOPT

function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ command}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-keymap-select

bindkey -v
bindkey -s "^[[O" ''
bindkey -s "^[[I" ''

cd .
