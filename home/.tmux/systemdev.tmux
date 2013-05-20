set-window-option allow-rename off
set visual-activity off
rename-window Editor
new-window -n Shells
splitw -h -p 30
splitw -v -p 50
selectp -L
new-window -n Logs "grc -es --colour=auto tail -f /var/log/apache2/error_log; zsh -i"
new-window -n Monitor "glances; zsh -i"
select-window -t 1

