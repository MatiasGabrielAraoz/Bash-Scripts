DOWNLOADS_DIR="$HOME/Descargas/"


inotifywait -m $DOWNLOADS_DIR -e create,moved_to,close_write | 
	while read -r directory action file; do
		echo "Se creó un archivo, organizandolo"
		bash "$HOME/BashScripts/DownloadsManager.sh"
	done

sleep 30
