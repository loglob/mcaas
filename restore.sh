#!/bin/sh
# restore.sh: Restore world/ from the latest backup in bak/
set -e
cd "$(realpath "$(dirname "$0")")"

if [ "$(systemctl is-active mc)" = "active" ]
then
	echo "Cannot load backup while server is running!"
	exit 1
fi

bak=$( ls -1 -t "bak" | head -1)

if [ -z "$bak" ]
then
	echo "No backups to load!"
	exit 1
fi

echo "Loading $bak..."

rm -r world/*
unzip "bak/$bak"
