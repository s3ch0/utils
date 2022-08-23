#!/bin/zsh

/usr/bin/amixer -qM set Master 5%+ umute
#pactl set-sink-volume @DEFAULT_SINK@ +5%
/bin/zsh ~/scripts/dwm-status-refresh.sh
