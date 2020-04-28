#!/usr/bin/env bash

# Syntax documentation here: https://github.com/LemonBoy/bar

killall lemonbar

. $(dirname $0)/config

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
      echo "MUSIC $icon_music $str"
    else
      echo "MUSIC %{}"
    fi

    sleep $MUSIC_SLEEP
  done
}

music > $PANEL_FIFO &

get_updates(){
  while true; do
    P_updates=`apt-get --just-print upgrade | awk -e '/([:digit:]+) upgraded/ {print $1}'`
    P_updates=$P_updates%%
    P_updates=$P_updates##

    if (( $P_updates > 4 )); then
      echo "UPDATE $icon_pacman $P_updates"
    else
      echo "UPDATE $icon_update 0"
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
    echo "DATE ${dates}"
    sleep $DATE_SLEEP
  done
}

datez > $PANEL_FIFO &

volume()
{
  cnt_vol=$upd_vol

  while true; do
    local sink=$( pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1 )
    local vol=$( pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $sink + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )

    if (( vol > 100 )); then
      echo "VOLUME $icon_vol $vol% "
    elif (( vol == 0 )); then
      echo "VOLUME $icon_vol_mute $vol% "
    elif (( vol > 70 )); then
      echo "VOLUME $icon_vol $vol% "
    elif (( vol > 55 )); then
      echo "VOLUME $icon_vol $vol% "
    elif (( vol > 10 )); then
      echo "VOLUME $icon_vol $vol% "
    else
      echo "VOLUME $icon_vol $vol% "
    fi

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
    echo "WIN $name %{}"

    sleep $WORKSPACE_SLEEP
  done
}

title > $PANEL_FIFO &

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
      fn_mem="$icon_mem ${line#MEM } "
      ;;
    CPU*)
      fn_cpu="$icon_cpu ${line#CPU } "
      ;;
    FREE*)
      fn_space="$icon_space ${line#FREE } "
      ;;
    WIN*)
      fn_win="${line#WIN }"
      ;;
  esac

  left="$fn_work  $fn_win"
  right="$fn_music  $fn_space $fn_mem $fn_cpu $fn_update  $fn_vol  $fn_date  "

  printf "%s\n" "$left%{r}$right"
done < $PANEL_FIFO |
  lemonbar -f $FONT1 -f $ICONFONT -g $GEOMETRY -B $BBG -F $BFG -u 2 |
  sh > /dev/null
