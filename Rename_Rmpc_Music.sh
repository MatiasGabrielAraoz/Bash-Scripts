#!/bin/sh
DOWNLOADED_MUSIC_DIR=$HOME/Music/rmpc_cache/youtube/

for file in $DOWNLOADED_MUSIC_DIR/*.opus; do
	[ -e "$file" ] || continue 

	base_name=$(basename "$file")
	echo "Procesando: $base_name"

	title=$(ffprobe -v quiet -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$file")
	artist=$(ffprobe -v quiet -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$file")
	
	if [ -z "$title" ]; then
		echo "no tiene metadatos este video"
		continue 
	fi
	artist_clean=$(echo "$title" | sed 's/[\/:*?"<>|]/-/g')
	title_clean=$(echo "$title" | sed 's/[\/:*?"<>|]/-/g')
	if [ -n "$artist" ]; then
		new_name="$title_clean - $artist_clean.opus"
	else
		new_name="$title_clean.opus"
	fi

	if [ "$file" != "$DOWNLOADED_MUSIC_DIR/$new_name" ]; then
		mv -v "$file" "$DOWNLOADED_MUSIC_DIR/$new_name"
	fi



done
