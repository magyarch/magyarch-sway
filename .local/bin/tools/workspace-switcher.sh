
#!/usr/bin/env bash

clients=$(hyprctl -j clients)

selection=$(echo "$clients" | jq -r '.[] | select(.title != "") | "[\(.workspace.id)] \(.title) [\(.class)] [\(.address)]"' | wofi --dmenu --prompt "Ablakok:")

[ -z "$selection" ] && exit 1

# Az ablakcím sorból kinyerjük a címkéket
window_addr=$(echo "$selection" | grep -oP '\[\K0x[a-fA-F0-9]+(?=\]$)')

# Fókuszálás az adott ablakra
hyprctl dispatch focuswindow address:$window_addr


