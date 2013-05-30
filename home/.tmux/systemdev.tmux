set-window-option -g allow-rename off
set-window-option -g visual-activity off
rename-window Editor
new-window -n Shells
splitw -h -p 30
splitw -v -p 50
selectp -L
new-window -n Logs "grc -es --colour=auto tail -f /var/log/apache2/error_log; zsh -i"
set-window-option allow-rename off
new-window -n Monitor "glances; zsh -i"
set-window-option allow-rename off
select-window -t 1

