#!/usr/bin/env bash

trap 'update' 5

FG="#c3cdc8"
BG="#000000"
WHITE="^fg(#c3cdc8)^bg()"
GREEN="^fg(#2e8b57)^bg()"
YELLOW="^fg(#F4F99D)^bg()"
RED="^fg(#FF6E67)^bg()"
WHITE="^fg(#E6E6E6)^bg()"
PINK="^fg(#FF92D0)^bg()"
BLUE="^fg(#477d8f)^bg()"
MAGENTA="^fg(#CAA9FA)^bg()"

CLEAN="^fg()^bg()"



xwin(){
  xwindow=$(echo "Windows: $GREEN`echo $(xdotool getwindowfocus getwindowclassname)`$CLEAN")
  echo -e "$xwindow"

}

wtr(){
  weat=$(curl 'wttr.in?format=%c')
  weat1=$(curl 'wttr.in?format=%t')
  weat2=$(curl 'wttr.in?format=%p')
  echo -e "  $weat1"
}

temp(){
  #temp="$(sensors | awk '/^Tdie:/ {print $2}')"
  temp="$(sensors | awk '/Core 0/ {print $3}')"
  echo -e "ﴦ $temp"
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e " $mem"

}

mhdd(){
    mhdd="$(df -h "/home" | awk ' /[0-9]/ {print $3 "/" $2}')"
    mhdd2="$(df -h "/mnt" | awk ' /[0-9]/ {print $3 "/" $2}')"
    echo " $mhdd  $mhdd2"
}

vol(){
	vol="$(pamixer --get-volume)"

if [ "$vol" -gt "70" ]; then
    icon="🔊"
elif [ "$vol" -gt "30" ]; then
    icon="🔉"
elif [ "$vol" -gt "0" ]; then
    icon="🔈"
else
        echo 🔇 && exit
fi

echo " $vol%"

}

kernel() {
    kernel="$(uname -r)"
    echo "  $kernel"
}

## BATTERY
bat() {
batstat="$(cat /sys/class/power_supply/BAT0/status)"
battery="$(cat /sys/class/power_supply/BAT0/capacity)"
    if [ $batstat = 'Charging' ]; then
    batstat="^"
    elif [ $batstat = 'Discharging' ]; then
    batstat="v"
    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
    batstat=""
    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
    batstat=""
    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
    batstat=""
    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
    batstat=""
    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
    batstat=""
    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
    batstat=""
fi

echo "$batstat  $battery %"

}

network() {
wifi="$(ip a | grep wlo1 | grep inet | wc -l)"

if [ $wifi = 1 ]; then
    echo "ok"
else
    echo "ng"
fi

}

dte(){
  dte="$(date +"%Y.%m.%d")"
  echo -e "$dte"
}

dte2(){
  dte2="$(date +"%H:%M")"
  echo -e "$dte2"
}

work(){
  #workspaces=`exec rpws current`
  workspaces=`ratpoison -c "groups"`
        echo "$workspaces" |
while read name; do
    if [[ "$name" =~ "*" ]]
    then
        selected=`echo $name | cut -c 3-`
        echo -n "^fg(#c3cdc8)^bg(#2e8b57) $selected $CLEAN"
    else
        notselected=`echo $name | cut -c 3-`
        echo -n " $notselected "
    fi

done

}

SLEEP_SEC=0.3

#loops forever outputting a line every SLEEP_SEC secs
while true; do
echo "M.2: $RED$(mhdd)$CLEAN"
sleep $SLEEP_SEC
done | dzen2 -ta -c -y '2560' -h 24 -fn "JetBrains Mono Nerd Font:size=12:antialias=true" -fg "#c3cdc8" -bg "#000000"

