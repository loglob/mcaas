#!/usr/bin/env sh
set -e
cd "$(realpath "$(dirname "$0")")"

if [ "$(./prop.sh enable-rcon)" != "true" ] || [ -z "$(./prop.sh rcon.password)" ] || [ -z "$(./prop.sh rcon.port)" ]
then
	>&2 echo "RCON needs to be enabled and configured!"
	exit 1
fi

echo " -jar fabric-server-launch.jar nogui " | cat jre_args - | xargs java
