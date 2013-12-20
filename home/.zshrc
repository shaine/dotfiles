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
plugins=(git svn vi-mode osx brew)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/lib/python2.7/site-packages:/usr/local/bin:$HOME/.bin:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

GRC=`which grc`
if [[ $? -eq 0 ]] && [ "$TERM" != dumb ]
then
    alias colourify="$GRC -es --colour=auto"
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
    alias tail='colourify tail'
    alias head='colourify head'
fi

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    $(in_svn) && echo '§' && return
    echo '○'
}

function is_dirty() {
    if $(in_svn)
    then
        echo $(svn_dirty_choose $ZSH_THEME_GIT_PROMPT_DIRTY $ZSH_THEME_GIT_PROMPT_CLEAN)
    else
        echo $(parse_git_dirty)
    fi
}

function prompt_info() {
    if $(in_svn)
    then
        ref=$(svn_get_branch_name) || return
    else
        ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    fi
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(is_dirty)${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function prompt_on() {
    RPROMPT="%T"

    PROMPT='%{$fg[blue]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(prompt_info)
$(prompt_char) '
    PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
}
function prompt_off() {
    RPROMPT=""

    PROMPT='\$ '
}
prompt_on

ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

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
function restartcoreaudio() {
    sudo kill -9 `ps ax|grep 'coreaudio[a-z]' |awk '{print $1}'`
}

# Nocorrects for ZSH
alias composer="nocorrect composer"

tm () { if [[ -z $* ]]; then tmux ls; else tmux attach-session -d -t $* || tmux new-session -s $*; fi }

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='exgxfxfxcxdxdxhbadbxbx'

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
