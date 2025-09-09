#!/usr/bin/env bash

WALLPAPERS_DIR="$HOME/.local/bin/wallpapers/Future"

# Get the list of available wallpapers
WALLPAPERS=$(ls "$WALLPAPERS_DIR")

# Use dmenu to display the list of wallpapers and get the selected filename
SELECTED=$(echo "$WALLPAPERS" | dmenu -i -l 20 -p "Select wallpaper:")

# Set the selected image as the new wallpaper
xwallpaper --no-randr --stretch "$WALLPAPERS_DIR/$SELECTED"

