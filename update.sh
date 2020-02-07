#!/bin/sh
# mcserver-download: Downloads the newest available minecraft server to minecraft_server.jar, overwriting any previous versions

set -e

dir="$(realpath "$(dirname "$0")")"
echo "Looking for newest minecraft server version..."

webpage="https://www.minecraft.net/en-us/download/server/"
selector="a[href$=\"server.jar\"]"
file="minecraft_server.jar"

# extract the <a> Element for the server.jar download
link=$(wget -q -O - "$webpage" | hxnormalize -x | hxselect "$selector")
# extract the Version of the found server.jar
version=$(echo "$link" | xmllint --xpath "string(/a)" -)
# extract the URL of the found server.jar
download=$(echo "$link" | xmllint --xpath "string(/a/@href)" -)

echo "Found $version"

wget -q --show-progress -O "$dir/$file" "$download"
chmod +x "$dir/$file"