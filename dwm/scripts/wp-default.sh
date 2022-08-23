#!/bin/bash

# feh --recursive --randomize --bg-fill ~/Images/wallpaper
ps -axf| grep wp-autochange.sh | grep Ss | cut -d" " -f2 | xargs kill -9 
feh --bg-fill ~/Pictures/wallpapers/wayfire.jpg

#feh --recursive --randomize --bg-fill ~/Pictures/wallpapers/view
