#!/usr/bin/env bash

killall xidlehook

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  --timer 600 \
    'betterlockscreen --lock dimblur' \
  &

xidlehook \
  `# Don't suspend when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't suspend when there's audio playing` \
  --not-when-audio \
  --timer 1800 \
    'systemctl suspend' \
  &
