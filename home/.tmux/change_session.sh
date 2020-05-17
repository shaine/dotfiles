new_path=$(tmux display-message -p -F "#{pane_current_path}" -t $SESSION:1.1)
file="/tmp/tmux_path"

if [[ $new_path == $(cat $file) ]]; then
  exit 0
fi

echo $new_path > $file

tmux send-keys -t side_top:1.1 C-c "cd $new_path; gitwatch" Enter C-l
tmux send-keys -t side_middle:1.1 C-c "cd $new_path" Enter C-l
tmux send-keys -t side_bottom:1.1 C-c "cd $new_path" Enter C-l
