#!/bin/bash
# backup.sh: Zips, timestamps and copies the world to bak/

set -e
dir="$(realpath "$(dirname "$0")")"
timestamp="$(date "+%Y-%m-%d %H:%M:%S")"

mkdir -p "$dir/bak"
zip -r "$dir/bak/$timestamp.zip" "$dir/world"
