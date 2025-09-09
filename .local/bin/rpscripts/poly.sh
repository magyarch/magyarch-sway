#!/usr/bin/env bash


CONFIG="$HOME/.config/polybar/config.ini"
TMP_CONFIG="/tmp/polybar_config_runtime.ini"

last_wm=""

while true; do
    # WM felismerése
    if pgrep -x herbstluftwm >/dev/null; then
        wm="herbstluftwm"
    elif pgrep -x ratpoison >/dev/null; then
        wm="ratpoison"
    else
        wm="unknown"
    fi

    # Ha változott a WM, akkor újrakonfigoljuk a polybart
    if [ "$wm" != "$last_wm" ]; then
        echo "[INFO] WM változás észlelve: $last_wm → $wm"

        # Összes polybar leállítása
        killall -q polybar
        while pgrep -x polybar >/dev/null; do sleep 0.5; done

        # Config másolása
        cp "$CONFIG" "$TMP_CONFIG"

        if [ "$wm" = "herbstluftwm" ]; then
            sed -i 's/^modules-center = .*/modules-center = ewmh/' "$TMP_CONFIG"
        elif [ "$wm" = "ratpoison" ]; then
            sed -i 's/^modules-center = .*/modules-center = workspaces/' "$TMP_CONFIG"
        fi

        # Polybar indítása új configgal
        polybar -c "$TMP_CONFIG" && ~/.config/polybar/launch.sh &

        last_wm="$wm"
    fi

    sleep 5
done

