#!/usr/bin/env bash

# Ensure Coolbits is set in X config (Option "Coolbits" "4")
# Must be run with sudo and DISPLAY/XAUTHORITY set

# Set the DISPLAY and XAUTHORITY if not set
export DISPLAY=${DISPLAY:-:0}
export XAUTHORITY=${XAUTHORITY:-/run/user/$(id -u)/.Xauthority}

# Optional: print info
echo "Using DISPLAY=$DISPLAY"
echo "Using XAUTHORITY=$XAUTHORITY"

# Enable manual fan control
nvidia-settings -a "[gpu:0]/GPUFanControlState=1"

# Get the current temperature of GPU (in Celsius)
# Function to adjust fan speed based on GPU temperature
adjust_fan_speed() {
TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)

echo "Current GPU Temperature: $TEMP°C"

# Adjust fan speed based on the temperature
if (( TEMP < 30 )); then
    FAN_SPEED=0  # Low fan speed
elif (( TEMP >= 30 && TEMP < 50 )); then
    FAN_SPEED=40  # Medium-low fan speed
elif (( TEMP >= 50 && TEMP < 70 )); then
    FAN_SPEED=75  # Medium fan speed
elif (( TEMP >= 70 && TEMP < 85 )); then
    FAN_SPEED=90  # High fan speed
else
    FAN_SPEED=100  # Max fan speed for high temps
fi

# Set the fan speed
echo "Setting fan speed to $FAN_SPEED%"
nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=$FAN_SPEED"

# Display the set fan speed and temperature
echo "Fan speed set to $FAN_SPEED% at a temperature of $TEMP°C"
}

# Continuously monitor the GPU temperature and adjust the fan speed
while true; do
    adjust_fan_speed
    sleep 5  # Check every 5 seconds
done
