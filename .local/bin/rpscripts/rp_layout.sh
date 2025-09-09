#!/usr/bin/env bash

declare options=("full
vertical
stack
horizontal
grid
Quit")

choice=$(echo -e "${options[@]}" | dmenu -c -g 1 -l 20 -fn 'JetBrains Mono Nerd Font-12' -p 'Layouts: ' -nb '#1a1a1a' -sb '#2e8b57')

case "$choice" in
    quit)
        echo "program terminated." && exit 1
    ;;
    full)
	    choice="$(ratpoison -c "echo Layout 1" -c "select -" -c "only" -c "next")"
    ;;
    vertical)
	    choice="$(ratpoison -c "echo Layout 2" -c "select -" -c "only" -c "hsplit" -c "next")"
    ;;
    stack)
	    choice="$(ratpoison -c "echo Layout 3" -c "select -" -c "only" -c "hsplit" -c "next" -c "focusright" -c "next" -c "vsplit" -c "next")"
    ;;
    horizontal)
	    choice="$(ratpoison -c "echo Layout 4" -c "select -" -c "only" -c "vsplit" -c "next")"
    ;;
    grid)
	    choice="$(ratpoison -c "echo Layout 5" -c "select -" -c "only" -c "hsplit" -c next -c "vsplit" -c next -c "focusright" -c next -c "vsplit" -c "next")"
esac

"$choice"

