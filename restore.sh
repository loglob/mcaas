#!/bin/sh
# restore.sh: Restore world/ from the latest backup in bak/

# Make sure we're in the server directory (or at least the directory the scripts are in)
cd "$(realpath "$(dirname "$0")")"

bak=$(ls -1 "bak" | tail -n 1)

if [ -z "bak/$bak" ]
then
	echo "No backups to load!"
	exit
fi

echo "Loading $bak..."

rm -r world/*
unzip "bak/$bak"
