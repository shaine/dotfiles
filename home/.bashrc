alias q='qlmanage -p'

export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[0;30m'
export COLOR_DARK_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'

alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
#export TERM=xterm-256color
export CLICOLOR=1
export PS1="\[${COLOR_BLUE}\]\u@\h \[${COLOR_GREEN}\]\w > \[${COLOR_NC}\]"

__git_ps1(){ echo "no"; }

if [ -f /usr/bin/git-completion.sh ]; then
 . /usr/bin/git-completion.sh
fi

git_dirty_flag() {
 if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]; then
   echo -e "${COLOR_RED}"

 else
   echo -e "${COLOR_DARK_GRAY}"
 fi
}

prompt_func() {
   previous_return_value=$?;
   prompt="\[${COLOR_BLUE}\]\u@\h \[${COLOR_GREEN}\]\w\[$(git_dirty_flag)\]$(__git_ps1) \[${COLOR_NC}\]"
   if test $previous_return_value -eq 0
   then
       PS1="${prompt}> "
   else
       PS1="${prompt}\[${COLOR_RED}\]> \[${COLOR_NC}\]"
   fi
}
export PROMPT_COMMAND=prompt_func

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# MacPorts Installer addition on 2011-05-03_at_13:10:15: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

cdd() {
  export my_dir=$1;
  ~/Documents/scripts/cd.sh $my_dir &> /dev/null;
  cd $my_dir;
}

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias vim="mvim -v"

alias pear="php /usr/lib/php/pear/pearcmd.php"
alias pecl="php /usr/lib/php/pear/peclcmd.php"
#alias tmux="TERM=screen-256color-bce tmux"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
