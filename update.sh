#!/bin/sh
# mcserver-download: Downloads the newest available minecraft server to minecraft_server.jar, overwriting any previous versions


# Make sure we're in the server directory (or at least the directory the scripts are in)
cd "$(realpath "$(dirname "$0")")"

if (! which curl > /dev/null 2>&1 )
then
	echo "Missing curl needed to get the minecraft webpage"
	exit
fi

if (! which hxnormalize > /dev/null 2>&1 || ! which hxselect > /dev/null 2>&1 )
then
	echo "Missing hxnormalie and hxselect needed for parsing the Minecraft webpage."
	echo "These are usually found in a html-xml-utils package."
	exit
fi

echo "Looking for newest minecraft server version..."

WEBPAGE="https://www.minecraft.net/en-us/download/server/"
SELECTOR="a[href$=\"server.jar\"]"
OUTFILE="minecraft_server.jar"

DL_LINK=$(curl -s "$WEBPAGE" | hxnormalize -x | hxselect "$SELECTOR")

DL_VERSION=$(echo "$DL_LINK" | cut -d"\"" -f 3 | cut -d">" -f 2 | cut -d"<" -f 1)
DL_FILE=$(echo "$DL_LINK" | cut -d"=" -f 2 | cut -d"\"" -f 2)

echo "Found $DL_VERSION"

wget -O "$OUTFILE" "$DL_FILE"
chmod +x "$OUTFILE"
mkdir -p bak world

echo "eula=true" > eula.txt
