#!/usr/bin/env sh
# exec.sh: Executes the given commands on the server
set -e
cd "$(realpath "$(dirname "$0")")"

export MCRCON_PORT=$(./prop.sh rcon.port)
export MCRCON_PASS=$(./prop.sh rcon.password)

mcrcon "$@"