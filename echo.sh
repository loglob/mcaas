#!/bin/sh
set -e
dir="$(realpath "$(dirname "$0")")"
screen_session=$(cat "$dir/conf/screen_session")

if [ $# -eq 0 ]
then
	while read line
	do
		screen -S "$screen_session" -X stuff "/say $line \n"
	done
else
	screen -S "$screen_session" -X stuff "/say $* \n"
fi