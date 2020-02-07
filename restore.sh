#!/bin/sh
# restore.sh: Restore world/ from the latest backup in bak/
set -e

dir="$(realpath "$(dirname "$0")")"
bak=$( ls -1 -t "$dir/bak" | head -1)

if [ -z "$bak" ]
then
	echo "No backups to load!"
	exit
fi

echo "Loading $bak..."

rm -r world/*
unzip "$dir/bak/$bak" -d "$dir"
