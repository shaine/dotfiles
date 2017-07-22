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

new -s discord -c ~/www/discord.squidtree.com
switch -t discord:1
source-file ~/.tmux/dev.tmux
send-keys -t 2.2 "gitwatch discord" Enter
