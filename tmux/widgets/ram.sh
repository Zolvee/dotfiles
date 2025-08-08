#!/usr/bin/env bash

ram_usage() {
  # macOS: vm_stat reports pages; convert to MB
  pagesize=$(vm_stat | awk '/page size of/ {print $8}')
  active=$(vm_stat | awk '/Pages active/ {gsub("\\.","",$3); print $3}')
  wired=$(vm_stat | awk '/Pages wired/ {gsub("\\.","",$4); print $4}')
  compressed=$(vm_stat | awk '/Pages occupied by compressor/ {gsub("\\.","",$6); print $6}')

  used_bytes=$(( (active + wired + compressed) * pagesize ))
  echo "$(( used_bytes / 1024 / 1024 ))MB"
}

printf "  %s\n" "$(ram_usage)"

