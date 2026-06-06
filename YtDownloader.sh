#!/usr/bin/env bash
MUSIC_DIR="$HOME/Music/rmpc_cache/youtube/"

if [ $# -eq 0 ]; then
    echo "Uso: $0 <link1> <link2> <link3> ..."
    exit 1
fi

yt-dlp -x --audio-format mp3 \
    --embed-thumbnail \
    --add-metadata \
    --force-overwrites \
    --convert-thumbnails jpg \
    -o "$MUSIC_DIR/%(title)s - %(uploader)s.%(ext)s" \
    "$@"
