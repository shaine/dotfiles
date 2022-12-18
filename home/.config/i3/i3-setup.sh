#! /bin/sh

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

i3-msg workspace 1

# terminal_command="(cat ~/.cache/wal/sequences &); clear; ssh athena.local; zsh"
# urxvt -e /bin/zsh -c "$terminal_command" &

~/.bin/tm-init

urxvt &
urxvt &
sleep 0.5
i3-msg split v
sleep 0.5
urxvt &
urxvt &
sleep 0.5
i3-msg split h
i3-msg resize shrink width 25 px or 25 ppt

# sleep 0.5
# i3-msg workspace 2
firefox &
# sleep 30
# i3-msg workspace 3
mailspring &
slack &
# sleep 20
# i3-msg workspace 4
spotify &
zotero &

