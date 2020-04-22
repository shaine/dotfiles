source ~/.tmux/tmuxcolors.conf
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

# new -s somename -c ~/www/some-project
# switch -t somename:1
# source-file ~/.tmux/dev.tmux
# send-keys -t 2.2 "gitwatch somename" Enter

new -s side_top
new -s side_middle
new -s side_bottom
switch -t system:1
