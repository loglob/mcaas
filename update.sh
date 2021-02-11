#!/usr/bin/env sh
# mcserver-download: Downloads the newest available minecraft server to minecraft_server.jar, overwriting any previous versions
set -e

# navigate to directory in which script is located
cd "$(realpath "$(dirname "$0")")"
echo "Looking for newest fabric installer..."

index="https://maven.fabricmc.net/net/fabricmc/fabric-installer/"
vers=$(wget -q -O - "$index" | egrep -o '[[:digit:]]+(\.[[:digit:]]+)+' | sort -un | tail -1 )

echo "Found version $vers, downloading..."

outf="fabric-installer.jar"
file="https://maven.fabricmc.net/net/fabricmc/fabric-installer/$vers/fabric-installer-$vers.jar"

wget -q --show-progress -O "$outf" "$file"

java -jar "$outf" server -downloadMinecraft

if [ -e mods/*.jar ]
then
	echo "note: Your installed mods may be out of date."
fi