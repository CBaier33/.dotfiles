#!/usr/bin/env bash

BOOKMARKS="$HOME/.config/scripts/bookmarks/bookmarks"

selection=$(
    awk -F'# ' '{print $2}' "$BOOKMARKS" |
    dmenu -i -l 50
)

[ -z "$selection" ] && exit 0

url=$(
    awk -F'# ' -v s="$selection" '$2 == s { print $1; exit }' "$BOOKMARKS"
)

[ -n "$url" ] && xdotool type --delay 0 "$url"
