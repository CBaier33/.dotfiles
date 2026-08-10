#!/bin/sh

bookmark="$(xclip -o)"
file=~/.config/scripts/bookmarks/bookmarks

if grep -q "^$bookmark.*#" "$file"; then
  notify-send "Oops," "$bookmark is already bookmarked."
else
  echo "$bookmark" >> "$file"
  notify-send "$bookmark added to bookmarks"
fi
