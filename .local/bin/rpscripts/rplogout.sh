#!/usr/bin/env bash

SRL="$(echo -e "Logout\nReboot\nShutdown\nCancel" | dmenu -i -c -g 1 -l 10 -nb '#282a36' -sb '#bd93f9' -fn 'JetBrains Mono Nerd Font-12' -p  'LOGOUT MENU:')"

case $SRL in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Logout)
        ratpoison -c quit
        ;;
    *)
        ;;
esac
