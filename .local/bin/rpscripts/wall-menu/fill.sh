#!/bin/sh -e

cd ~/.local/bin/wallpapers/Future/

img=$(printf '%s\n' * | dmenu -i -c -g 1 -l 20 -p 'Fill: ' -nb '#1a1a1a' -sb '#2e8b57' -fn 'JetBrains Mono Medium-12')

[ -f "$img" ] && feh --bg-fill "$img" && notify-send "Style: fill" && notify-send "File: $img"
