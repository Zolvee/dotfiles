#!/usr/bin/env bash

battery() {
  pmset -g batt | grep -Eo '[0-9]+%' | head -1
}

echo "  $(battery)"
