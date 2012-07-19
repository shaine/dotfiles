#!/usr/bin/env osascript

tell application "System Events"
    set process_list to (name of every process)
end tell

if process_list contains "Adium" then
    tell application "Adium"
        set x to 0
        repeat with theChat in (every chat)
            set x to x + (unread message count of theChat)
        end repeat
        if x > 0 then
            set adium to  "✦ " & x
        end if
    end tell
end if
