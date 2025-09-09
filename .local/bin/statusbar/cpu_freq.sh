#!/usr/bin/env bash

# Get the CPU frequency in MHz
cpu_freq=$(cat /proc/cpuinfo | grep MHz | awk '{sum+=$4} END {printf "%.2f", sum/NR}')

# Print the CPU frequency
echo "${cpu_freq} MHz"

