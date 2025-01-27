#!/usr/bin/env sh
# start.sh: Starts the server. Doesn't exit until server exits.
set -e
cd "$(realpath "$(dirname "$0")")"

if [ "$(./prop.sh enable-rcon)" != "true" ] || [ -z "$(./prop.sh rcon.password)" ] || [ -z "$(./prop.sh rcon.port)" ]
then
	>&2 echo "RCON needs to be enabled and configured!"
	exit 1
fi

# use JRE from JAVA_HOME if set, system default otherwise
if [ -z "$JAVA_HOME" ]
then
	JRE=java
else
	JRE="$JAVA_HOME"/bin/java
fi

echo " -jar fabric-server-launch.jar nogui " | cat jre_args - | xargs "$JRE"
