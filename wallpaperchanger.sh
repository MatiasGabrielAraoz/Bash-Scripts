#!/bin/bash
WALLPAPERS_DIR="$HOME/Wallpapers/"
while true; do
	wallpapers=($WALLPAPERS_DIR/*)
	SELECTED_WALL=$(printf "%s\n" "${wallpapers[@]}" | shuf -n 1)
	swww img $SELECTED_WALL
	matugen image "$SELECTED_WALL" \
        -m dark \
        -t scheme-content \
        --source-color-index 0 \
        -j hex | jq -r '.colors | to_entries | .[] | "@define-color \(.key) \(.value.dark.color);"' > ~/.config/waybar/colors.css

	sleep 0.5
	systemctl --user restart waybar.service
	sleep 600
done
