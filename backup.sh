#!/bin/bash
# backup.sh: Zips, timestamps and copies the world to bak/

set -e
dir="$(realpath "$(dirname "$0")")"
timestamp="$(date "+%Y-%m-%d %H:%M:%S")"
screen_session=$(cat "$dir/conf/screen_session")

if ( screen -ls | grep -q -w -F "$screen_session" )
then
	# setup a process that listens for the server to be done saving
	tail -f -n 0 "$dir/log/latest.log" | grep -q -F "[Server thread/INFO]: Saved the game" &
	# flush world changes to disk
	"$dir/exec.sh" save-all flush
	# wait for flush to finish
	wait $!
fi

mkdir -p "$dir/bak"
jar cfM "$dir/bak/$timestamp.zip" -C "$dir" "world"