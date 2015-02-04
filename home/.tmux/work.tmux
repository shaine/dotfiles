# Create work session
new-window
rename-window Shells
split-window -h
resize-pane -R 30
split-window -v
selectp -L
new-window -t 3 -n Watchers
send-keys "grunt tdd" Enter
split-window -h
send-keys "grunt" Enter
link-window -s system:3
kill-window -t 1
new-window -d -t 1 -n Editor

# Create watchers session
new-session -s workWatchers
link-window -s work:3
kill-window -t 1
move-window -t 1

# Switch back to work session
switch -t work:1
send-keys "vim" Enter
