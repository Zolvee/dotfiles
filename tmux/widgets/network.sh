#!/usr/bin/env bash
# macOS bandwidth meter for tmux: shows current DL/UL speeds

# Pick the default route's interface (e.g., en0/en1)
IFACE=$(route -n get default 2>/dev/null | awk '/interface:/{print $2}')
[ -z "$IFACE" ] && { echo "📶 n/a"; exit 0; }

read_bytes() {
  # Sum Ibytes/Obytes across rows for the iface (link + inet)
  # Columns (macOS): ... Ibytes=$7 Obytes=$10
  netstat -ibnI "$IFACE" 2>/dev/null \
    | awk 'NR>1 {rx+=$7; tx+=$10} END{printf "%s %s", rx, tx}'
}

read -r rx1 tx1 <<<"$(read_bytes)"
sleep 1
read -r rx2 tx2 <<<"$(read_bytes)"

dr=$((rx2 - rx1))
dt=$((tx2 - tx1))

human() {
  local bps=$1
  local k=$((bps / 1024))
  local m=$((k / 1024))
  if [ $m -ge 1 ]; then
    printf "%dMB/s" "$m"
  elif [ $k -ge 1 ]; then
    printf "%dKB/s" "$k"
  else
    printf "%dB/s" "$bps"
  fi
}

printf " ↓%s ↑%s\n" "$(human "$dr")" "$(human "$dt")"
