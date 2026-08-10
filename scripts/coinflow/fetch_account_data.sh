#!/bin/sh

timestring=$(date +"%y%m%d-%H%M")

OUTPUT_FILE="${1:-bitcoin_report-${timestring}.csv}"

output=$(coinflow export-csv \
  --electrum-url tcp://electrum.blockstream.info:50001 \
  --xpub xpub6DAxyyaoAjeoeXco5K3PsXgGeTidFSqFtMjwHW2kFpWVCQfFu45r3do9kSGrhP9NURHqgtyHw9yrW1H2FHhYvh3a4QpYuT5weP8zyzd55zF \
  --format actual \
  --output "/home/topher/owncloud/finance/crypto/${OUTPUT_FILE}" \
  2>&1 | tee output.log)

value=$(echo "$output" | awk -F': ' '/Current value:/ {print $2}')

if [ -z "$value" ]; then
    notify-send "coinflow" "fetch failed."
    exit 1
fi

notify-send "coinflow" "Current value: $value"
