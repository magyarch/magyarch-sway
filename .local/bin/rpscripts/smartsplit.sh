#!/usr/bin/env bash
# Usage: smart-split.sh hsplit|vsplit

cmd="$1"
[ -z "$cmd" ] && exit 1

# 1) frame ID-k osztás előtt
before_ids=$(ratpoison -c "fdump" | awk '{print $1}' | sort)

# 2) osztás
ratpoison -c "$cmd"

# 3) frame teljes lista és ID-k osztás után
after_full=$(ratpoison -c "fdump")
after_ids=$(echo "$after_full" | awk '{print $1}' | sort)

# 4) új frame ID-je = különbség
new_id=$(comm -13 <(echo "$before_ids") <(echo "$after_ids"))

# 5) ha van új ID, keressük meg a SORSZÁMÁT (indexét) az "after_full"-ban
if [ -n "$new_id" ]; then
  # a sor sorszáma (1-től), mi 0-tól számozunk → index = NR-1
  index=$(echo "$after_full" | awk -v id="$new_id" '$1==id{print NR-1; exit}')

  # 6) fókusz az új frame-re (0-indextől próbál)
  if [ -n "$index" ]; then
    if ! ratpoison -c "fselect $index" 2>/dev/null; then
      # ha a build 1-től indexelne, fallback: +1
      ratpoison -c "fselect $((index+1))" 2>/dev/null
    fi
  fi
else
  # Ha valamiért nem talált különbséget, próbáljuk az "other"-t
  ratpoison -c "next" -c "focus"
fi

