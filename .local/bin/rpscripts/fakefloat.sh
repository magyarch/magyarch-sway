#!/usr/bin/env bash

# Ratpoison fake gaps toggle (center <-> fullscreen)

statefile="/tmp/ratpoison_padding"

if [ -f "$statefile" ]; then
    ratpoison -c "set padding 0 33 0 0"
    rm -f "$statefile"
else
    ratpoison -c "set padding 350 300 350 300"
    touch "$statefile"
fi
