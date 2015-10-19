# Create work session
new-window
rename-window Shells
split-window -h
resize-pane -R 30
split-window -v
selectp -L
link-window -s system:3
kill-window -t 1
new-window -d -t 1 -n Editor

# Create watchers session
new-session -s workWatchers
send-keys "grunt" Enter
kill-window -t 1
move-window -t 1

# Switch back to work session
switch -t work:1
send-keys "vim" Enter
