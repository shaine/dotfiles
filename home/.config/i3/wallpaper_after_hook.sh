#!/usr/bin/env bash

wallpaper_path=$(cat $HOME/.cache/wal/wal)

betterlockscreen -u $wallpaper_path -b 1 &

$HOME/.config/lemonbar/run_lemonbar.sh &

killall dunst
dunst &
