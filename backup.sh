#!/bin/bash
# backup.sh: Zips, timestamps and copies the world to bak/

set -e
dir="$(realpath "$(dirname "$0")")"
timestamp="$(date "+%Y-%m-%d %H:%M:%S")"

mkdir -p "$dir/bak"
jar cfM "$dir/bak/$timestamp.zip" -C "$dir" "world"