#!/usr/bin/env bash

WORKSPACES=("WWW" "Code" "Term")

# ha kattintás történt
if [[ "$1" == "--click" ]]; then
    idx=$2
    ws=${WORKSPACES[$idx]}
    stumpish "(gselect \"$ws\")"
    exit 0
fi

# aktív group neve
active=$(stumpish '(stumpwm::group-name (stumpwm::current-group))')

# Polybar output
for i in "${!WORKSPACES[@]}"; do
    ws=${WORKSPACES[$i]}
    if [ "$ws" = "$active" ]; then
        printf "%%{F#FF8800}[%s]%%{F-} " "$ws"
    else
        printf "%s " "$ws"
    fi
done

echo
