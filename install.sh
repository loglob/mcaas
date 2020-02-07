#!/bin/sh
# install.sh: Standalone script for downloading and installing the minecraft server
SRV_DIR="/srv/mc"

genService () {
echo "[Unit]
	Description=Minecraft server
	After=network-online.target
	Wants=network-online.target

[Service]
	Type=forking
	ExecStart=$SRV_DIR/start.sh
	ExecStop=$SRV_DIR/stop.sh

[Install]
	WantedBy=multi-user.target
"
}

require () {
	MSG="$1"
	shift
	for i in $@
	do
		if (! which $i > /dev/null 2>&1 )
		then
			echo "Missing $i, which is required for $MSG"
			exit
		fi
	done
}

require "downloading the server" wget
require "downloading scripts" git
require "parsing the Minecraft webpage" hxnormalize hxselect xmllint
require "running the Minecraft server" java screen
set -e

if [ $# -gt 0 ]
then
	SRV_DIR=$(realpath "$1")
fi

git clone --depth 1 https://github.com/loglob/mcaas "$SRV_DIR"
rm -rf "$SRV_DIR/.git" "$SRV_DIR/install.sh" "$SRV_DIR/README.md"
"$SRV_DIR/update.sh"

read -p "Do you want to create a service file? " serv
case $serv in
	[Yy]* ) genService > /etc/systemd/system/mc.service ;;
esac

read -p "Do you accept the Minecraft EULA? (https://account.mojang.com/documents/minecraft_eula) " eula
case $eula in
	[Yy]* ) echo "eula=true" > eula.txt; echo "You can now start the server using '$SRV_DIR/start.sh' or 'service mc start'.";;
	* ) echo "You have to accept the EULA before you can use the server. You can do this by editing $SRV_DIR/eula.txt";;
esac