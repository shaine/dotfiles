# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#export ZSH_THEME="random"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode osx)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#export PATH=/opt/local/bin:/opt/local/sbin:/Users/shaine/.rvm/gems/ruby-1.9.2-p290/bin:/Users/shaine/.rvm/gems/ruby-1.9.2-p290@global/bin:/Users/shaine/.rvm/rubies/ruby-1.9.2-p290/bin:/Users/shaine/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/Users/shaine/.rvm/bin:/Users/shaine/.rvm/bin
export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  echo '○'
}

function battery_charge {
  echo `$BAT_CHARGE` 2>/dev/null
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='%{$fg[blue]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info)
$(virtualenv_info)$(prompt_char) '

RPROMPT='$VIMODE'

ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local ZSH config if it exists

alias pear="php /usr/lib/php/pear/pearcmd.php"
alias pecl="php /usr/lib/php/pear/peclcmd.php"
alias git-com="nocorrect git-com"
alias tmux="tmux -2 -u"
alias phperrors="tail -f /var/log/apache2/error_log"
alias tmuxcopy="tmux show-buffer | tr -d '\n' | pbcopy"
alias "tmux ns"="tmux new-session -s "
alias ls="ls -GF"
alias lol="fortune | cowthink | lolcat"

tm () { tmux attach-session -t $* || tmux new-session -s $* }
rm () { mv $* ~/.Trash }

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

cd .
