#!/bin/bash
# backup.sh: Zips, timestamps and copies the world to bak/

# Make sure we're in the server directory (or at least the directory the scripts are in)
cd "$(realpath "$(dirname "$0")")"

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
mkdir -p "bak"

zip -r "bak/$TIMESTAMP.zip" "world"
