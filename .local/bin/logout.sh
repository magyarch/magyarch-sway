#!/usr/bin/env bash

# Wofi menü opciók
chosen=$(printf "⏻  Leállítás\n  Kijelentkezés\n  Újraindítás\n  Felfüggesztés" | wofi --dmenu --prompt "Rendszer művelet:")

case "$chosen" in
    "⏻  Leállítás") exec systemctl poweroff ;;
    "  Újraindítás") exec systemctl reboot ;;
    "  Kijelentkezés") exec swaymsg exit ;;
    "  Felfüggesztés") exec systemctl suspend ;;
esac

