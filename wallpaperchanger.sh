#!/bin/bash
WALLPAPERS_DIR="$HOME/Wallpapers/"
while true; do
	wallpapers=($WALLPAPERS_DIR/*)
	SELECTED_WALL=$(printf "%s\n" "${wallpapers[@]}" | shuf -n 1)
	hyprpanel sw "$SELECTED_WALL"

	sleep 600
done
