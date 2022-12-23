#!/usr/bin/env sh
# mcserver-download: Downloads the latest available Fabric installer and server
set -e
cd "$(realpath "$(dirname "$0")")"

echo "Looking for newest fabric installer..."

index="https://maven.fabricmc.net/net/fabricmc/fabric-installer/"
vers=$(wget -q -O - "$index" | grep -E -o '[[:digit:]]+(\.[[:digit:]]+)+' | sort --version-sort | tail -1 )

echo "Found version $vers, downloading..."

outf="fabric-installer.jar"
file="https://maven.fabricmc.net/net/fabricmc/fabric-installer/$vers/fabric-installer-$vers.jar"

wget -q --show-progress -O "$outf" "$file"

java -jar "$outf" server -downloadMinecraft

if [ -e mods ] && [ -n "$(ls mods)" ]
then
	echo "note: Your installed mods may be out of date."
fi
