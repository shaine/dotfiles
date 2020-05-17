# oh-my-zsh squidtree Theme

if [ -z "$SSH_CLIENT" ]; then
  _USERNAME="%{$fg[white]%}%n"
  _LIBERTY="%{$fg[green]%}$"
else
  _USERNAME="%{$fg[red]%}%n"
  _LIBERTY="%{$fg[red]%}#"
fi
_HOST="%{$fg[blue]%}%m%{$reset_color%}"
_USERNAME="$_USERNAME%{$reset_color%}"
_LIBERTY="$_LIBERTY%{$reset_color%}"
_PATH="%{$fg[green]%}%~%{$reset_color%}"


_1LEFT=$_USERNAME@$_HOST:$_PATH
PROMPT='$_1LEFT
$_LIBERTY '
RPROMPT="%{$fg[green]%}"%D{"%H:%M:%S"}%b"%{$reset_color%}"
