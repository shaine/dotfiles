#!/usr/bin/env bash

wallpaper_path=$(ls $HOME/.config/bg/* | shuf -n 1)
wal_backend=$(cat $HOME/.config/bg/.wal-backend)

wal -c
wal --backend $wal_backend -i $wallpaper_path -o "$HOME/.config/i3/wallpaper_after_hook.sh"
