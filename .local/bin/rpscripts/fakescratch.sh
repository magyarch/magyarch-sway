#!/usr/bin/env bash
# Ratpoison scratchpad Alacritty-val

STATEFILE="/tmp/ratpoison_scratchpad"

if [ -f "$STATEFILE" ]; then
    # Scratchpad már fut → bezárjuk, layout visszaáll, padding kinulláz
    ratpoison -c "kill"
    ratpoison -c "frestore 0"
    ratpoison -c "padding 0 0 0 0"
    rm -f "$STATEFILE"
else
    # Mentjük a layoutot
    ratpoison -c "fdump 0"
    # Padding beállítás scratchpadhez
    ratpoison -c "padding 300 300 300 300"
    # Csak a scratchpad maradjon
    ratpoison -c "only"
    ratpoison -c "exec alacritty -e rmpc"
    touch "$STATEFILE"
fi

