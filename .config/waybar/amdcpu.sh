#!/usr/bin/env bash

# Általános CPU használat
read -r _ user nice system idle iowait irq softirq steal _ < <(grep '^cpu ' /proc/stat)
PREV_TOTAL=$((user + nice + system + idle + iowait + irq + softirq + steal))
PREV_IDLE=$idle
sleep 0.2
read -r _ user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 _ < <(grep '^cpu ' /proc/stat)
TOTAL=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2))
IDLE=$idle2

DIFF_TOTAL=$((TOTAL - PREV_TOTAL))
DIFF_IDLE=$((IDLE - PREV_IDLE))
CPU_USAGE=$(( (100 * (DIFF_TOTAL - DIFF_IDLE)) / DIFF_TOTAL ))

# Hőmérséklet
TEMP=$(sensors | grep -m 1 -Po 'Tctl:\s+\+?\K[0-9.]+(?=°C)')

# Frekvencia
FREQ=$(awk -F: '/^cpu MHz/ { sum += $2; count++ } END { if (count > 0) print int(sum / count); else print "N/A" }' /proc/cpuinfo)

# Magonkénti CPU kihasználtság
CORE_USAGES=()
while read -r line; do
  [[ $line =~ ^cpu[0-9]+ ]] || continue
  cpu_id=$(echo "$line" | awk '{print $1}')
  prev_idle=$(echo "$line" | awk '{print $5}')
  prev_total=$(echo "$line" | awk '{sum=0; for(i=2;i<=NF;i++) sum+=$i; print sum}')
  
  sleep 0.03
  
  line2=$(grep "^$cpu_id " /proc/stat)
  curr_idle=$(echo "$line2" | awk '{print $5}')
  curr_total=$(echo "$line2" | awk '{sum=0; for(i=2;i<=NF;i++) sum+=$i; print sum}')
  
  diff_total=$((curr_total - prev_total))
  diff_idle=$((curr_idle - prev_idle))
  
  if [ "$diff_total" -ne 0 ]; then
    usage=$((100 * (diff_total - diff_idle) / diff_total))
    CORE_USAGES+=("${usage}%")
  fi
done < <(grep '^cpu[0-9]' /proc/stat)

# Tooltip szöveg elkészítése
USAGE_STRING=$(IFS=' '; echo "${CORE_USAGES[*]}")
TOOLTIP=$(printf "Frekvencia: %s MHz\n%s" "$FREQ" "$USAGE_STRING" | sed ':a;N;$!ba;s/\n/\\n/g')

# JSON kimenet
echo "{\"text\": \"🧠 ${CPU_USAGE}% ${TEMP}°C\", \"tooltip\": \"$TOOLTIP\"}"
