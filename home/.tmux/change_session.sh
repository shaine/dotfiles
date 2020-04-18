path=$(tmux display-message -p -F "#{pane_current_path}" -t $SESSION:1.1)

tmux respawn-pane -t side_top:1.1 -k "RUN='cd $path; gitwatch' zsh"
tmux respawn-pane -t side_middle:1.1 -k "RUN='cd $path' zsh"
tmux respawn-pane -t side_bottom:1.1 -k "RUN='cd $path' zsh"
