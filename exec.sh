#!/bin/sh
# Execs the given command on the minecraft server screen

set -e
dir="$(realpath "$(dirname "$0")")"
screen_session="$(cat "$dir/conf/screen_session")"

if [ -z "$screen_session" ]
then
	>&2 echo "/src/mc/conf/screen_session may not be empty"
fi

screen -S "$screen_session" -X stuff "$*\n"