#!/usr/bin/env bash

cpu_usage() {
  ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f%%", s}'
}

echo "  $(cpu_usage)"
