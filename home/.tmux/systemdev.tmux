set-window-option -g allow-rename off
set-window-option -g visual-activity off
rename-window Editor
send-keys "cd ~/.homesick/repos/dotfiles/home; nvim" Enter
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
send-keys -t 2.2 "gitwatch ostk" Enter

new -s watchers -c ~/www
switch -t watchers:1
split-window -v
send-keys -t 1.1 "cd mobile-deux" Enter
send-keys -t 1.2 "cd mobile-deux" Enter
new-window
split-window -v
send-keys -t 2.1 "cd overstock" Enter
send-keys -t 2.2 "cd overstock" Enter
select-window -t 1

new -s deux -c ~/www/mobile-deux
switch -t deux:1
source-file ~/.tmux/dev.tmux
send-keys -t 2.2 "gitwatch deux" Enter
