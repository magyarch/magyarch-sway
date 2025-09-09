#!/usr/bin/env bash


# Hőmérséklet lekérése
TEMP_RAW=$(sensors | awk '/amdgpu-pci-/{f=1} f && /edge/ {gsub(/\+|°C/,"",$2); print $2; exit}')
TEMP_INT=${TEMP_RAW%.*}

# Ikon, szín és class hőmérséklet alapján
if (( TEMP_INT < 45 )); then
    ICON=""
    COLOR="#00afff"
    CLASS="cool"
elif (( TEMP_INT < 70 )); then
    ICON=""
    COLOR="#ffaa00"
    CLASS="warm"
else
    ICON=""
    COLOR="#ff4444"
    CLASS="hot"
fi

# JSON kimenet — tooltip elhagyva!
echo -n "{"
echo -n "\"text\": \"$ICON ${TEMP_INT}°C\", "
echo -n "\"class\": \"$CLASS\", "
echo -n "\"color\": \"$COLOR\""
echo "}"

