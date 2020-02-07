#!/bin/sh
# mcserver-download: Downloads the newest available minecraft server to minecraft_server.jar, overwriting any previous versions

SRV_DIR=$(dirname "$(realpath "$0")")
set -e

if (! which curl > /dev/null 2>&1 )
then
	echo "Missing curl needed to get the minecraft webpage"
	exit
fi

if (! which hxnormalize > /dev/null 2>&1 || ! which hxselect > /dev/null 2>&1 )
then
	echo "Missing hxnormalize and hxselect needed for parsing the Minecraft webpage."
	echo "These are usually found in a html-xml-utils package."
	exit
fi

if (! which xmllint > /dev/null 2>&1 )
then
	echo "Missing xmllint needed for parsing the Minecraft webpage."
	exit
fi

echo "Looking for newest minecraft server version..."

WEBPAGE="https://www.minecraft.net/en-us/download/server/"
SELECTOR="a[href$=\"server.jar\"]"
OUTFILE="minecraft_server.jar"

# extract the <a> Element for the server.jar download
LINK=$(wget -q -O - "$WEBPAGE" | hxnormalize -x | hxselect "$SELECTOR")
# extract the Version of the found server.jar
VERSION=$(echo "$LINK" | xmllint --xpath "string(/a)" -)
# extract the URL of the found server.jar
FILE=$(echo "$LINK" | xmllint --xpath "string(/a/@href)" -)

echo "Found $VERSION"

wget -q --show-progress -O "$SRV_DIR/$OUTFILE" "$FILE"
chmod +x "$SRV_DIR/$OUTFILE"

#echo "eula=true" > eula.txt
