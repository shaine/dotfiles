set visual-activity off
rename-window Editor
new-window -n Shells
splitw -h -p 30
splitw -v -p 50
selectp -L
new-window -n Yii "tail -f protected/runtime/application.log; zsh -i"
splitw -h -p 50
link-window -s system:3
link-window -s system:4
select-window -t 1

