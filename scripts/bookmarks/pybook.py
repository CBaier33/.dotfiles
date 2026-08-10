#!/usr/bin/env python3

import json
import sys

def extract_bookmarks(node, bookmarks):
    if isinstance(node, dict):
        if node.get("type") == "url":
            url = node.get("url", "").strip()
            name = node.get("name", "").strip()
            bookmarks.append(f"{url} # {name}")

        for value in node.values():
            extract_bookmarks(value, bookmarks)

    elif isinstance(node, list):
        for item in node:
            extract_bookmarks(item, bookmarks)

def main():
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} bookmarks.json output.txt")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    with open(input_file, "r", encoding="utf-8") as f:
        data = json.load(f)

    bookmarks = []
    extract_bookmarks(data, bookmarks)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write("\n".join(bookmarks))

    print(f"Wrote {len(bookmarks)} bookmarks to {output_file}")

if __name__ == "__main__":
    main()
