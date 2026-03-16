#!/bin/bash

DESTINY=/sdcard/Music


for file in $HOME/Music/rmpc_cache/youtube/*; do
	if ! adb get-state 1>/dev/null 2>&1; then
		echo "Error"
		exit 1
	fi
	filename=$(basename "$file")
	if adb shell stat "$DESTINY/\"$filename\"" < /dev/null 2>&1; then
		echo "saltando $filename pq ya existe"
	else
		echo "Metiendo: $filename"
		adb push "$file" "$DESTINY"
	fi
done
