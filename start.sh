#!/bin/sh
# mcserver-start: starts a screen to run a minecraft server

set -e
dir="$(realpath "$(dirname "$0")")"
screen_session=$(cat "$dir/conf/screen_session")

if [ -z "$screen_session" ]
then
	>&2 echo "$dir/conf/screen_session may not be empty"
	exit
fi

# The arguments to the JRE (i.e. -Xmx). May be empty.
jre_args=$(cat "$dir/conf/jre_args")

# Minecraft won't work unless the eula.txt is in the current working directory
cd "$dir"
screen -d -m -S "$screen_session" java $jre_args -jar minecraft_server.jar nogui