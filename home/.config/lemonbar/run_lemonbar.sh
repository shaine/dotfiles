#!/usr/bin/env bash

# Syntax documentation here: https://github.com/LemonBoy/bar

killall lemonbar

source ~/.cache/wal/colors.sh

# Sleep constants
MUSIC_SLEEP=3
UPDATE_SLEEP=30
WORKSPACE_SLEEP=0.3
DATE_SLEEP=1
VOLUME_SLEEP=1

# Icons
#                          
icon_cpu="CPU"
icon_mem="RAM"
icon_vol="VOL"
icon_pacman="APT"
icon_space="SDD"

# Colors
BBG="#D0${color0/'#'}"
BFG="#${color15/'#'}"
silver_color="#${color7/'#'}"
green_color="#${color2/'#'}"
red_color="#${color9/'#'}"
label_color="%{F$silver_color}"
value_color="%{F$green_color}"
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

music() {
  while true; do
    NCMP=$(spotifycli --status)
    NUM_NCMP=$(echo $NCMP | head -1 | wc -c )
    S_NCMP=$(echo $NCMP | head -1 | head -c 30)
    PLAYBACK_STATUS=$(spotifycli --playbackstatus)

    str=""

    if [[ "▶" = $PLAYBACK_STATUS ]]; then
      if [[ $NUM_NCMP -le 31 ]]; then
        str=$NCMP
      else
        str="$S_NCMP..."
      fi
      echo "MUSIC $value_color$str$spacer$reset"
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
    # P_updates=$P_updates%%
    # P_updates=$P_updates##

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
    echo "DATE $value_color$dates$reset"
    sleep $DATE_SLEEP
  done
}

datez > $PANEL_FIFO &

volume()
{
  cnt_vol=$upd_vol

  while true; do
    local vol=$(pulsemixer --get-volume | head -n1 | cut -d " " -f1)

    # if (( vol > 100 )); then
      # echo "VOLUME $icon_vol $vol% "
    # elif (( vol == 0 )); then
      # echo "VOLUME $icon_vol_mute $vol% "
    # elif (( vol > 70 )); then
      # echo "VOLUME $icon_vol $vol% "
    # elif (( vol > 55 )); then
      # echo "VOLUME $icon_vol $vol% "
    # elif (( vol > 10 )); then
      # echo "VOLUME $icon_vol $vol% "
    # else
      # echo "VOLUME $icon_vol $vol% "
    # fi

    echo "VOLUME $label_color$icon_vol $value_color$vol%$spacer$reset"

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

title > $PANEL_FIFO &

res_w=$(xrandr | grep "current" | awk '{print $8a}')
WIDTH=$res_w # bar width
HEIGHT=18 # bar height
XOFF=0 # x offset
YOFF=0 # y offset
FONT1="6x13"
ICONFONT="FontAwesome:size=9"
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

  left="$fn_work  $fn_win"
  right="$fn_update$fn_music$fn_space$fn_mem$fn_cpu$fn_vol$fn_date  "

  printf "%s\n" "$left%{r}$right"
done < $PANEL_FIFO |
  lemonbar -f $FONT1 -g $GEOMETRY -B $BBG -u 2 |
  sh > /dev/null
