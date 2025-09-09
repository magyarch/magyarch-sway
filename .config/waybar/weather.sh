#!/usr/bin/env bash

# --- Beállítások ---
LOCATION="Sopron"
CACHE_FILE="$HOME/.cache/weather.json"
MAX_AGE_MINUTES=30

# --- Frissítés logika ---
needs_update=false

# --force kapcsoló esetén
if [[ "$1" == "--force" ]]; then
  needs_update=true
fi

# Ha nincs fájl vagy régi, akkor frissítünk
if [[ ! -f "$CACHE_FILE" ]]; then
  needs_update=true
elif [[ $(( $(date +%s) - $(date -r "$CACHE_FILE" +%s) )) -gt $((MAX_AGE_MINUTES * 60)) ]]; then
  needs_update=true
fi

# Frissítés, ha kell
if $needs_update; then
  curl -s "https://wttr.in/${LOCATION}?format=j1" > "$CACHE_FILE"
fi

# --- Adatok feldolgozása ---
if [[ -f "$CACHE_FILE" ]]; then
  TEMP_NOW=$(jq -r '.current_condition[0].temp_C' "$CACHE_FILE")
  TEMP_MIN=$(jq -r '.weather[0].mintempC' "$CACHE_FILE")
  TEMP_MAX=$(jq -r '.weather[0].maxtempC' "$CACHE_FILE")
  RAIN=$(jq -r '[.weather[0].hourly[].chanceofrain | tonumber] | max' "$CACHE_FILE")

  # Időjárás ikon (opcionálisan fejleszthető állapottal is)
  ICON="🌡️"
  RAIN_ICON="☔"

  echo -n "{\"text\": \"${ICON} ${TEMP_NOW}°C ${RAIN_ICON} ${RAIN}%\", "
  echo -n "\"tooltip\": \"❄️ Min: ${TEMP_MIN}°C\\n🌞 Max: ${TEMP_MAX}°C\\nLocation: ${LOCATION}\"}"
else
  echo '{"text": "⚠️ N/A", "tooltip": "No weather data."}'
fi
