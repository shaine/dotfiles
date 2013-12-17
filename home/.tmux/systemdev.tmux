set-window-option -g allow-rename off
set-window-option -g visual-activity off
rename-window Editor
send-keys "cd ~/.homesick/repos/dotfiles/home; vim" Enter
new-window -n Shells
splitw -h -p 30
splitw -v -p 50
selectp -L
new-window -n Monitor "glances; zsh -i"
set-window-option allow-rename off
select-window -t 1

