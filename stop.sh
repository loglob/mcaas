#!/usr/bin/env sh
# stop.sh: Stops the server. Waits until server exits.
set -e
cd "$(realpath "$(dirname "$0")")"
SERVICE=""

if [ -e *.service ] 2>&-
then
	SERVICE=$(basename *.service .service)
else
	SERVICE="$(basename "$(pwd)")"
	>&2 echo "Not sure how the service is called based on *.service files, going with '$SERVICE'"
fi

# retrieve PID of running server
PID="$(systemctl show --property MainPID --value "$SERVICE")"

if [ PID == 0 ]
then
	>&2 echo "Can't get PID for service $SERVICE, is it correct and running?"
	exit 1
fi

# setup a background process that waits for the server to exit
tail --pid=$PID -f /dev/null &

./exec.sh /stop

# wait for server to actually exit
wait $!