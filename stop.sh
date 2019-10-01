#!/bin/sh
# mcserver-stop: stops a running minecraft server screen

# Make sure we're in the server directory (or at least the directory the scripts are in)
cd "$(realpath "$(dirname "$0")")"

cd /srv/mcexec.sh stop