set-window-option -g allow-rename off
set-window-option -g visual-activity off
rename-window Editor
new-window -n Shells
splitw -h -p 30
splitw -v -p 50
selectp -L
select-window -t 1

