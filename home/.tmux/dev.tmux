new-window
rename-window Shells
split-window -h
resize-pane -R 30
split-window -v
selectp -L
link-window -s system:3
kill-window -t 1
new-window -d -t 1 -n Editor
select-window -t 1
send-keys "nvim" Enter
split-window -h
resize-pane -R 70
send-keys "gitwatch" Enter
split-window -v
resize-pane -U 15
split-window -v
selectp -L
