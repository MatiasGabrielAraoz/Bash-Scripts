#!/usr/bin/env bash

echo "Arreglando Historial"
mv "$HOME/.zsh_history" "$HOME/.zsh_history_bad"
strings "$HOME/.zsh_history_bad" > "$HOME/.zsh_history"
echo "Historial arreglado"
