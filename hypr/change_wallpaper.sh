#!/bin/sh

cd ~/Pictures/wallpapers
options=$(ls -1)
chosen_wallpaper=$(printf "$options" | tofi --num-results=11 --height=305)
awww img ~/Pictures/wallpapers/"$chosen_wallpaper" $1
