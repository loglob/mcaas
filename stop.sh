#!/bin/sh
# mcserver-stop: stops a running minecraft server screen
SCREEN_NAME="mc-screen"

#retrieve PID of screen session
PID=$(screen -S "$SCREEN_NAME" -Q echo '$PID')
# setup a background process that waits for the screen to exit
tail --pid=$PID -f /dev/null &
screen -X stuff "stop\n"
# wait for server to actually exit
wait $!
