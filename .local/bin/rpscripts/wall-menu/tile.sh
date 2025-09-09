#!/bin/sh -e

cd ~/.local/bin/wallpapers/Future/

img=$(printf '%s\n' * | dmenu -i -c -g 1 -l 20 -p ' Tile: ' -nb '#2f2b26' -sb '#2e8b57' -fn 'JetBrains Mono Medium-12')

[ -f "$img" ] && feh --bg-tile "$img" && notify-send "Style: tile" && notify-send "File: $img"
