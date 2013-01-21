set-window-option -g allow-rename off
set visual-activity off
rename-window Editor
new-window -n Shells
splitw -h -p 30
splitw -v -p 50
selectp -L
splitw -v -p 85
link-window -s system:4
select-window -t 1

