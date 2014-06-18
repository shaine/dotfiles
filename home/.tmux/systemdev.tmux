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
new-window -n Monitor "glances; zsh -i"
set-window-option allow-rename off
select-window -t 1

