#!/usr/bin/env bash



# Dmenu script for editing some of my more frequently edited config files.


declare options=("hlwm
ratpoison
bspwmrc
nixconfig
xmonad
sxhkdrc
hyprland
polybar
.xprofile
quit")

choice=$(echo -e "${options[@]}" | rofi -dmenu -p 'Edit files: ')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	hlwm)
		choice="$HOME/.config/herbstluftwm/autostart"
	;;
	ratpoison)
		choice="$HOME/.ratpoisonrc"
	;;
	bspwmrc)
		choice="$HOME/.config/bspwm/bspwmrc"
	;;
	xmonad)
		choice="$HOME/.config/xmonad/xmonad.hs"
	;;
	sxhkdrc)
	        choice="$HOME/.config/sxhkd/sxhkdrc"
	;;
	hyprland)
		choice="$HOME/.config/hypr/hyprland.conf"
	;;
	nixconfig)
		choice="/etc/nixos/configuration.nix"
	;;
	polybar)
		choice="$HOME/.config/polybar/config.ini"
	;;
    xprofile)
		choice="$HOME/.xprofile"
	;;
	*)
		exit 1
	;;
esac
kitty -e nvim  "$choice"
