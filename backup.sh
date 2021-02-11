#!/bin/bash
# backup.sh: Zips, timestamps and copies the world to bak/
cd "$(realpath "$(dirname "$0")")"


status=$(systemctl is-active mc)
timestamp="$(date "+%Y-%m-%d %H:%M:%S")"
mkdir -p "bak"

if [ "$status" = "active" ]
then
	# flush world changes to disk
	./exec.sh "/save-all flush"
fi

jar cfM "bak/$timestamp.zip" "world"
