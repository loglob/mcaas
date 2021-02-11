#!/usr/bin/env sh
# echo.sh: Echoes its arguments or stdin to ingame chat.
set -e
cd "$(realpath "$(dirname "$0")")"

if [ $# -eq 0 ]
then
	awk '{ printf "/say %s\n",$0 }' | xargs -d '\n' ./exec.sh
else
	./exec.sh "/say $*"
fi