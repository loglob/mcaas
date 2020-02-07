#!/bin/sh
# mcserver-stop: stops a running minecraft server screen

dir="$(realpath "$(dirname "$0")")"
screen_session=$(cat "$dir/conf/screen_session")

#retrieve PID of screen session
PID=$(screen -S "$screen_session" -Q echo '$PID')
# setup a background process that waits for the screen to exit
tail --pid=$PID -f /dev/null &
screen -X stuff "stop\n"
# wait for server to actually exit
wait $!
