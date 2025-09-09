#!/usr/bin/env bash



# Gyors programlista a PATH alapján
Menu=$(compgen -c | sort -u | fzf --prompt="Run application: " \
    --border=rounded \
    --color='bg:#282a36,fg:#ebdbb2,hl:#6272a4' \
    --margin=5% \
    --height 100% \
    --reverse \
)
#    --header="          PROGRAMS " --info=hidden)

if [ -n "$Menu" ]; then
    hyprctl dispatch exec "$Menu"
fi

