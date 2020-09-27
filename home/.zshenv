PATH="${PATH}:/usr/local/bin"

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
if [ -e /home/shaine/.nix-profile/etc/profile.d/nix.sh ]; then . /home/shaine/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
