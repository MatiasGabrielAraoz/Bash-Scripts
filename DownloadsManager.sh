#!/bin/bash

DOWNLOADS_DIR="$HOME/Descargas/"

mkdir -p $DOWNLOADS_DIR/{Imágenes,Vídeos,Audio,Pdfs,Comprimidos,Binarios,Otros}

for file in $DOWNLOADS_DIR/*; do
	type=$(file --mime-type -b $file)
	case "$type" in
	inode/directory)
			echo "Salteando $type porque es un directorio"
			continue ;;
		image/*)
			echo "Moviendo $file a $DOWNLOADS_DIR/Imágenes"
			mv "$file" $DOWNLOADS_DIR/Imágenes/ ;;

		video/*)
			echo "Moviendo $file a $DOWNLOADS_DIR/Vídeos"
			mv "$file" $DOWNLOADS_DIR/Vídeos/ ;;
		audio/*)
			echo "Moviendo $file a $DOWNLOADS_DIR/Audio"
			mv "$file" $DOWNLOADS_DIR/Audio/ ;;
		application/pdf|application/epub+zip)
			echo "Moviendo $file a $DOWNLOADS_DIR/Pdfs"
			mv "$file" $DOWNLOADS_DIR/Pdfs/ ;;
		application/gzip|application/zip|application/rar|application/gz|application/tar|application/7z|application/bz2)
			echo "Moviendo $file a $DOWNLOADS_DIR/Comprimidos"
			mv "$file" $DOWNLOADS_DIR/Comprimidos ;;
		application/x-*)
			echo "Moviendo $file a $DOWNLOADS_DIR/Binarios"
			mv "$file" $DOWNLOADS_DIR/Binarios ;;
	*)
			case "$type" in 
				docx|doc|txt|xlsx)
					echo "Moviendo $file a $DOWNLOADS_DIR/Documentos"
					mv "$file" $DOWNLOADS_DIR/Documentos ;;
				*)
					echo "Moviendo $file a $DOWNLOADS_DIR/Otros"
					mv "$file" $DOWNLOADS_DIR/Otros
		
				esac
		;;
		esac 
	done

