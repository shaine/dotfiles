set-window-option -g allow-rename off
set-window-option -g remain-on-exit on
set visual-activity off
rename-window Editor
new-window -n Shells
splitw -h -p 30
splitw -v -p 50
selectp -L
new-window -n Logs "grc -es --colour=auto tail -f /var/log/apache2/error_log"
new-window -n Monitor glances
select-window -t 1

