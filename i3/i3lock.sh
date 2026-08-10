#!/usr/bin/env bash

BACKGROUND="${1:-$HOME/Pictures/wallpaper.jpg}"
RES=$(xdpyinfo | awk '/dimensions/{print $2}')

convert "$BACKGROUND" \
  -resize "${RES}^" \
  -gravity center \
  -extent "${RES}" \
  RGB:- | \
i3lock \
  --ignore-empty-password \
  --clock \
  --date-str="%B %d %Y" \
  --indicator \
  --inside-color=F5E7DEFF \
  --ring-color=4b5263FF \
  --line-color=00000000 \
  --separator-color=00000000 \
  --verif-color=00000000 \
  --insidever-color=F5E7DEFF \
  --ringver-color=F5E7DEFF \
  --wrong-color=00000000 \
  --keyhl-color=BF8F60FF \
  --bshl-color=B23636FF \
  --ring-width=8 \
  --radius=120 \
  --raw "${RES}:rgb" \
  --image /dev/stdin
