#!/usr/bin/env bash

# Syntax documentation here: https://github.com/LemonBoy/bar

killall lemonbar

source ~/.cache/wal/colors.sh

# Sleep constants
MUSIC_SLEEP=3
BATTERY_SLEEP=60
UPDATE_SLEEP=30
WORKSPACE_SLEEP=0.3
DATE_SLEEP=1
VOLUME_SLEEP=1
NETWORK_SLEEP=30

# Icons
icon_cpu="CPU"
icon_mem="RAM"
icon_vol="VOL"
icon_pacman="APT"
icon_space="SDD"
icon_battery="BAT"
icon_network="NET"

# Colors
BBG="#D0${color0/'#'}"
BFG="#${color15/'#'}"
silver_color="#${color7/'#'}"
green_color="#${color2/'#'}"
blue_color="#${color12/'#'}"
red_color="#${color9/'#'}"
label_color="%{F$silver_color}"
value_color="%{F$green_color}"
title_color="%{F$blue_color}"
warning_value_color="%{F$red_color}"
reset="%{F- B-}"

spacer="   "

# Display queue
PANEL_FIFO=/tmp/panel-fifo
if [ -e $PANEL_FIFO ]; then
  rm $PANEL_FIFO
fi
mkfifo $PANEL_FIFO

conky -c $(dirname $0)/lemonbar_conky > $PANEL_FIFO &

battery() {
  while true; do
    BATTERY_PERCENTAGE=$(acpitool | head -n 1 | cut -f 1 -d . | cut -f 2 -d , | tr -d '[:space:]')

    if [[ "$BATTERY_PERCENTAGE" == *"notavailable"* ]]; then
      return
    else
      if (( BATTERY_PERCENTAGE < 20 )); then
        color=$warning_value_color
      else
        color=$value_color
      fi
      echo "BATTERY $label_color$icon_battery $color$BATTERY_PERCENTAGE%$spacer$reset"
    fi

    sleep $BATTERY_SLEEP
  done
}

battery > $PANEL_FIFO &

network() {
  while true; do
    NETWORK_NAME=$(iwgetid -r)

    if [ ! -z "$NETWORK_NAME" ]; then
      echo "NETWORK $label_color$icon_network $value_color$NETWORK_NAME$spacer$reset"
    else
      return
    fi

    sleep $NETWORK_SLEEP
  done
}

network > $PANEL_FIFO &

music() {
  while true; do
    NCMP=$(spotifycli --status)
    NUM_NCMP=$(echo $NCMP | head -1 | wc -c )
    # S_NCMP=$(echo $NCMP | head -1 | head -c 30)
    PLAYBACK_STATUS=$(spotifycli --playbackstatus)

    str=""

    if [[ "▶" = $PLAYBACK_STATUS ]]; then
      # if [[ $NUM_NCMP -le 31 ]]; then
        str=$NCMP
      # else
        # str="$S_NCMP..."
      # fi
      echo "MUSIC $title_color$str$spacer$reset"
    else
      echo "MUSIC %{}"
    fi

    sleep $MUSIC_SLEEP
  done
}

music > $PANEL_FIFO &

get_updates(){
  while true; do
    P_updates=`apt list --upgradeable | wc -l`
    P_updates="$(($P_updates-1))"

    if (( $P_updates > 4 )); then
      echo "UPDATE $label_color$icon_pacman $warning_value_color$P_updates$spacer$reset"
    else
      echo "UPDATE %{}"
    fi
    sleep $UPDATE_SLEEP
  done
}

get_updates > $PANEL_FIFO &

work(){
  while true; do
    local seq="$(eval echo \"$($HOME/.config/lemonbar/workspace.rb)\")"
    echo "WORKSPACES $seq"
    sleep $WORKSPACE_SLEEP
  done
}

work > $PANEL_FIFO &

datez()
{
  while true; do
    local dates="$(date +'%Y.%m.%d %T')"
    echo "DATE $title_color$dates$reset"
    sleep $DATE_SLEEP
  done
}

datez > $PANEL_FIFO &

volume()
{
  cnt_vol=$upd_vol

  while true; do
    local vol=$(pulsemixer --get-volume | head -n1 | cut -d " " -f1)
    local mute=$(pulsemixer --get-mute)

    if (( mute == 1 )); then
      value="${warning_value_color}MUTE"
    elif (( vol > 100 )); then
      value="$warning_value_color$vol%"
    else
      value="$value_color$vol%"
    fi

    echo "VOLUME $label_color$icon_vol $value$spacer$reset"

    sleep $VOLUME_SLEEP
  done
}

volume > $PANEL_FIFO &

title()
{
  while true; do
    id=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
    name=$(xprop -id $id | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
    num_title=$(echo $name | wc -c)

    if (( num_title > 60 )); then
      name="$(echo $name | head -1 | head -c 60)..."
    fi
    echo "WIN $value_color$name$reset"

    sleep $WORKSPACE_SLEEP
  done
}

# title > $PANEL_FIFO &

res_w=$(xrandr | grep "current" | awk '{print $8a}')
WIDTH=$res_w # bar width
HEIGHT=18 # bar height
XOFF=0 # x offset
YOFF=0 # y offset
# FONT1="6x13"
FONT1="Terminus (TTF):size=9"
GEOMETRY="${WIDTH}x${HEIGHT}+${XOFF}+${YOFF}"

while read -r line; do
  case $line in
    DATE*)
      fn_date="${line#DATE }"
      ;;
    VOLUME*)
      fn_vol="${line#VOLUME }"
      ;;
    WORKSPACES*)
      fn_work="${line#WORKSPACES }"
      ;;
    MUSIC*)
      fn_music="${line#MUSIC }"
      ;;
    BATTERY*)
      fn_battery="${line#BATTERY }"
      ;;
    NETWORK*)
      fn_network="${line#NETWORK }"
      ;;
    UPDATE*)
      fn_update="${line#UPDATE }"
      ;;
    MEM*)
      fn_mem="$label_color$icon_mem $value_color${line#MEM }$spacer$reset"
      ;;
    CPU*)
      fn_cpu="$label_color$icon_cpu $value_color${line#CPU }$spacer$reset"
      ;;
    FREE*)
      fn_space="$label_color$icon_space $value_color${line#FREE }$spacer$reset"
      ;;
    WIN*)
      fn_win="${line#WIN }"
      ;;
  esac

  left="$fn_work  $fn_music"
  right="$fn_update$fn_space$fn_mem$fn_cpu$fn_network$fn_vol$fn_battery$fn_date  "

  printf "%s\n" "$left%{r}$right"
done < $PANEL_FIFO |
  lemonbar -f "$FONT1" -g $GEOMETRY -B $BBG -u 2 |
  sh > /dev/null
