#!/bin/sh
# mcserver-start: starts a screen to run a minecraft server

# Make sure we're in the server directory (or at least the directory the scripts are in)
cd "$(realpath "$(dirname "$0")")"

# The screen session name to use for the minecraft server screen
screen_session=$(cat conf/screen_session)

if [ -z "$screen_session" ]
then
	>&2 echo "/srv/mc/conf/screen_session may not be empty"
	exit
fi

# The arguments to the JRE (i.e. -Xmx). May be empty.
jre_args=$(cat conf/jre_args)

screen -d -m -S "$screen_session" java $jre_args -jar minecraft_server.jar nogui