set-window-option -g allow-rename off
set-window-option -g visual-activity off
rename-window Editor
send-keys "cd ~/.homesick/repos/dotfiles/home; vim" Enter
new-window
rename-window Shells
split-window -h
resize-pane -R 30
split-window -v
selectp -L
new-window -n Monitor
set-window-option allow-rename off
select-window -t 1

new -s work -c ~/www/overstock
switch -t work:1
source-file ~/.tmux/dev.tmux
new -s watchers -c ~/www
switch -t watchers:1
source-file ~/.tmux/dev.tmux
new -s deux -c ~/www/mobile-deux
switch -t deux:1
source-file ~/.tmux/dev.tmux
