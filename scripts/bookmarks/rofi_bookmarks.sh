#!/usr/bin/env bash

BOOKMARKS="$HOME/.config/scripts/bookmarks/bookmarks"
ROFI_THEME="$HOME/.config/rofi/launchers/type-1/style-7.rasi"
ICON="/usr/share/icons/Humanity/apps/16/addressbook.svg"

selection=$(
    while IFS='#' read -r url name; do
        name="${name# }"
        printf '%s\0icon\x1f%s\n' "$name" "$ICON"
    done < "$BOOKMARKS" |
    rofi -dmenu \
         -show-icons \
         -i \
         -matching fuzzy \
         -p "Bookmarks" \
         -theme "$ROFI_THEME"
)

[ -z "$selection" ] && exit 0

url=$(
    awk -F'# ' -v s="$selection" '$2 == s { print $1; exit }' "$BOOKMARKS"
)

xdotool type --delay 0 "$url"
