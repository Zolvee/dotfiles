#!/usr/bin/env bash

battery() {
  pmset -g batt | grep -Eo '[0-9]+%' | head -1
}

cpu_usage() {
  ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f%%", s}'
}

ram_usage() {
  used=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
  total=$(sysctl hw.memsize | awk '{print $2}')
  used_bytes=$((used * 4096))
  echo "$((used_bytes / 1024 / 1024))MB"
}



echo "  $(cpu_usage) |   $(ram_usage)"
