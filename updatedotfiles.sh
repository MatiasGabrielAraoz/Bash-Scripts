#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
STOW_FLAGS="--restow"
GIT_BRANCH="main"
finished=()
with_errors=()

cd "$DOTFILES_DIR" || exit 1

for paquete in */; do
	nombre=$(basename "$paquete")
	if stow $STOW_FLAGS "$nombre";then 
	echo "COMPLETADO $nombre"
	finished+=("$nombre")
else 
	echo "Falló $nombre" 
	with_errors+=("$nombre")
fi
done

UPDATED_STR=""
for package in "${finished[@]}"; do
	UPDATED_STR+="$package, "
done

git add -A 
if [[ -n $(git status --porcelain) ]]; then
	echo "Comitting changes"
	git commit -m "Updated dotfiles $UPDATED_STR" 
	git push origin $GIT_BRANCH
else 
	echo "No changes to commit"
	exit 1
fi


