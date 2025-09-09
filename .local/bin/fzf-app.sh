#!/usr/bin/env bash


# Alkalmazáslista generálása
choices=$(find /usr/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null |
  while read -r desktop; do
    name=$(grep -m1 '^Name=' "$desktop" | cut -d= -f2-)
    exec=$(grep -m1 '^Exec=' "$desktop" | cut -d= -f2- | sed 's/ *%[fFuUdDnNickvm]//g')
    [[ -n "$name" && -n "$exec" ]] && echo -e "$name\t$exec"
  done | sort)

# dmenu-szerű fzf
selected=$(echo "$choices" | cut -f1 | \
  fzf --prompt=">" \
      --height=1 \
      --layout=reverse \
      --border=none \
      --no-info \
      --color=fg:#ffffff,bg:#1e1e1e,hl:#ffcc00 \
      --reverse)

# Indítás, ha kiválasztottak valamit
if [[ -n "$selected" ]]; then
  cmd=$(echo "$choices" | grep -F "$selected" | cut -f2-)
  nohup $cmd >/dev/null 2>&1 &
fi

