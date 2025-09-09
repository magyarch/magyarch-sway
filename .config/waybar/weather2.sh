#!/usr/bin/env bash

# --- Beállítások ---
LOCATION="Sopron"
CACHE_FILE="$HOME/.cache/weather.json"
MAX_AGE_MINUTES=30

# --- Frissítés logika ---
needs_update=false

if [[ "$1" == "--force" ]]; then
  needs_update=true
fi

if [[ ! -f "$CACHE_FILE" ]]; then
  needs_update=true
elif [[ $(( $(date +%s) - $(date -r "$CACHE_FILE" +%s) )) -gt $((MAX_AGE_MINUTES * 60)) ]]; then
  needs_update=true
fi

if $needs_update; then
  curl -s "https://wttr.in/${LOCATION}?format=j1" > "$CACHE_FILE"
fi

# --- Adatok feldolgozása ---
if [[ -f "$CACHE_FILE" ]]; then
  TEMP_NOW=$(jq -r '.current_condition[0].temp_C' "$CACHE_FILE")
  TEMP_MIN=$(jq -r '.weather[0].mintempC' "$CACHE_FILE")
  TEMP_MAX=$(jq -r '.weather[0].maxtempC' "$CACHE_FILE")
  RAIN=$(jq -r '[.weather[0].hourly[].chanceofrain | tonumber] | max' "$CACHE_FILE")
  WEATHER_DESC=$(jq -r '.current_condition[0].weatherDesc[0].value' "$CACHE_FILE")
  WIND_KPH=$(jq -r '.current_condition[0].windspeedKmph' "$CACHE_FILE")
  UV_INDEX=$(jq -r '.current_condition[0].uvIndex' "$CACHE_FILE")

  # Állapot ikon kiválasztása
  case "$WEATHER_DESC" in
    *Thunderstorm*) ICON="⛈️";;
    *Rain*|*Drizzle*) ICON="🌧️";;
    *Snow*) ICON="❄️";;
    *Cloud*|*Overcast*) ICON="☁️";;
    *Sunny*) ICON="☀️";;
    *Clear*) ICON="🌙";;
    *Fog*|*Mist*) ICON="🌫️";;
    *) ICON="🌡️";;
  esac

  TEXT="${ICON} ${TEMP_NOW}°C ☔ ${RAIN}%"
  TOOLTIP="🌤️ ${WEATHER_DESC}
❄️ Min: ${TEMP_MIN}°C
🌞 Max: ${TEMP_MAX}°C
💨 Wind: ${WIND_KPH} km/h
🔆 UV Index: ${UV_INDEX}
📍 Location: ${LOCATION}"

  echo "{\"text\": \"${TEXT}\", \"tooltip\": \"${TOOLTIP//$'\n'/\\n}\"}"
else
  echo '{"text": "⚠️ N/A", "tooltip": "No weather data."}'
fi

