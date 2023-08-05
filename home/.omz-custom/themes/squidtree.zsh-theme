# oh-my-zsh squidtree Theme

_ENTRY="$"
_HOST_SEP="@"
_PATH_SEP=":"
_TMUX_SEP="+"

_HOSTNAME="%m"
  _HOST_COLOR=white

if [ -z "$SSH_CLIENT" ] && [ ! -f /.dockerenv ]; then
  _USERNAME_COLOR=blue
  _TMUX_COLOR=cyan
  _HOSTNAME=""
else
  _USERNAME_COLOR=red
  _TMUX_COLOR=magenta
fi

if [ -v CONTAINER_NAME ]; then
  _HOSTNAME="$CONTAINER_NAME'"
fi

if [ -n "$TMUX" ]; then
  _TMUX_SESSION="%{$fg[$_TMUX_COLOR]%}$_TMUX_SEP$(tmux display-message -p '#S')%{$reset_color%}"
else
  _TMUX_SESSION=""
fi

if [ -z "$_HOSTNAME" ]; then
  _HOST_SEP=""
fi

_USERNAME="%{$fg[$_USERNAME_COLOR]%}%n%{$reset_color%}"
_LIBERTY="%{$fg[green]%}$_ENTRY%{$reset_color%}"
_HOST="%{$fg[$_HOST_COLOR]%}$_HOSTNAME%{$reset_color%}"
_PATH="%{$fg[green]%}%~%{$reset_color%}"


_1LEFT=$_USERNAME$_HOST_SEP$_HOST$_TMUX_SESSION$_PATH_SEP$_PATH
PROMPT='$_1LEFT
$_LIBERTY '
RPROMPT="%{$(echotc UP 1)%}%{$fg[green]%}"%D{"%H:%M:%S"}%b"%{$reset_color%}%{$(echotc DO 1)%}"
