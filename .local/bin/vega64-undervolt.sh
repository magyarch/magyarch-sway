#!/usr/bin/env bash

# P6 undervolt: 1450 MHz @ 975 mV
echo "6 1490 1000" | sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage

# P7 undervolt: 1490 MHz @ 1000 mV
echo "7 1536 1000" | sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage

# Apply changes
echo "c" | sudo tee /sys/class/drm/card1/device/pp_od_clk_voltage
