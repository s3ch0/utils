#!/bin/bash
/bin/zsh ~/scripts/wp-default.sh &
/bin/zsh ~/scripts/dwm-status.sh &
# /bin/zsh ~/scripts/wp-autochange.sh &
# picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
picom -o 0.8 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
# picom -b
/bin/zsh ~/scripts/tap-to-click.sh &
/bin/zsh ~/scripts/inverse-scroll.sh &
nm-applet &
xfce4-power-manager &
#xfce4-volumed-pulse &
/bin/zsh ~/scripts/run-mailsync.sh &
~/scripts/autostart_wait.sh &

