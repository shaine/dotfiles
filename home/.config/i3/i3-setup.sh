#! /bin/sh

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

i3-msg workspace 1

terminal_command="(cat ~/.cache/wal/sequences &); clear; ssh athena; zsh"

i3-sensible-terminal -e "$terminal_command"
i3-sensible-terminal -e "$terminal_command"

i3-msg split v

i3-sensible-terminal -e "$terminal_command"
i3-sensible-terminal -e "$terminal_command"

i3-msg split h
i3-msg resize shrink width 25 px or 25 ppt

i3-msg workspace 2

chromium-browser &
slack &

sleep 3

i3-msg workspace 3

spotify &

sleep 3

i3-msg workspace 1
