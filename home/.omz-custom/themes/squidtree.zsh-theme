# oh-my-zsh squidtree Theme

if [ -z "$SSH_CLIENT" ]; then
  _USERNAME_COLOR=white
  _HOST_COLOR=blue
else
  _USERNAME_COLOR=red
  _HOST_COLOR=magenta
fi
_USERNAME="%{$fg[$_USERNAME_COLOR]%}%n%{$reset_color%}"
_LIBERTY="%{$fg[green]%}$%{$reset_color%}"
_HOST="%{$fg[$_HOST_COLOR]%}%m%{$reset_color%}"
_PATH="%{$fg[green]%}%~%{$reset_color%}"


_1LEFT=$_USERNAME@$_HOST:$_PATH
PROMPT='$_1LEFT
$_LIBERTY '
RPROMPT="%{$fg[green]%}"%D{"%H:%M:%S"}%b"%{$reset_color%}"
