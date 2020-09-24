#! /bin/sh

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

i3-msg workspace 1

# terminal_command="(cat ~/.cache/wal/sequences &); clear; ssh athena.local; zsh"
# urxvt -e /bin/zsh -c "$terminal_command" &

urxvt &
urxvt &

sleep 1

i3-msg split v

sleep 1

urxvt &
urxvt &

sleep 1

i3-msg split h
i3-msg resize shrink width 25 px or 25 ppt

sleep 2

i3-msg workspace 2

chromium-browser &
slack &

sleep 30

i3-msg workspace 3

minetime &
mailspring &

sleep 20

i3-msg workspace 4

spotify &

sleep 10

i3-msg workspace 5

pritunl-client-electron

sleep 10

i3-msg workspace 1
