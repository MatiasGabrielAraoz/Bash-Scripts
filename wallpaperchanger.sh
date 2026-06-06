#!/usr/bin/env bash

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-0}"

WALLPAPERS_DIR="$HOME/Wallpapers/"
while true; do
	if ! awww query; then
		echo "Daemon no detectado"
		awww-daemon &
		sleep 0.5
	fi

	mapfile -t wallpapers < <(find "$WALLPAPERS_DIR" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \))
	if [ ${#wallpapers[@]} -eq 0 ]; then
		echo "No se encontraron wallpapers en $WALLPAPERS_DIR"
		sleep 10
		continue
	fi

	SELECTED_WALL=$(printf "%s\n" "${wallpapers[@]}" | shuf -n 1)
	awww img "$SELECTED_WALL"
	matugen image "$SELECTED_WALL" \
        -m dark \
        -t scheme-content \
        --source-color-index 0 \
        -j hex | jq -r '.colors | to_entries | .[] | "@define-color \(.key) \(.value.dark.color);"' > ~/.config/waybar/colors.css

	sleep 1

	killall -q waybar
	sleep 0.3
	waybar %>/dev/null &
	
	sleep 600
done
