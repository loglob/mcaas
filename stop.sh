#!/usr/bin/env sh
set -e
cd "$(realpath "$(dirname "$0")")"

# retrieve PID of running server
pid="$(systemctl show --property MainPID --value mc)"
# setup a background process that waits for the server to exit
tail --pid=$PID -f /dev/null &

./exec.sh /stop

# wait for server to actually exit
wait $!