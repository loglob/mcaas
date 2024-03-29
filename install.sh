#!/bin/sh
# install.sh: Standalone script for downloading and installing the minecraft server
# If an argument is given, use that directory for the server
dir="/srv/mc"

genService () {
echo "[Unit]
	Description=Minecraft server
	After=network-online.target
	Wants=network-online.target

[Service]
	Type=simple
	ExecStart=$dir/start.sh
	ExecStop=$dir/stop.sh

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
require "parsing the Fabric webpage" hxnormalize hxselect xmllint
require "running the Minecraft server" java
require "running the admin scripts" mcrcon
set -e

if [ $# -gt 0 ]
then
	dir=$(realpath "$1")
fi

mkdir -p "$dir"
git clone --depth 1 https://github.com/loglob/mcaas "$dir"
rm -rf "$dir/.git" "$dir/install.sh" "$dir/README.md"
"$dir/update.sh"
genService > "$dir/mc.service"

#run jar once to generate default server.properties etc
(
	echo "Generating default server config..."
	cd "$dir"
	rm -f "eula.txt"
	java -jar "$dir/fabric-server-launch.jar" nogui > /dev/null
)

read -p "Do you accept the Minecraft EULA? (https://account.mojang.com/documents/minecraft_eula) " eula
case $eula in
	[Yy]* ) echo "eula=true" > "$dir/eula.txt"; echo "You can now start the server using '$dir/start.sh' or 'service mc start'.";;
	* ) echo "You have to accept the EULA before you can use the server. You can do this by editing $dir/eula.txt";;
esac

read -p "Do you want to install the service now? " serv
case $serv in
	[Yy]* )
		ipath="/etc/systemd/system/mc.service"
		sudo ln -sf "$(realpath "$dir/mc.service")" "$ipath"
		systemctl daemon-reload
		echo "link service file placed in $ipath"

		read -p "Do you want to automatically start the server on system startup? " autoinstall
		case $autoinstall in
			[Yy]* )
				systemctl enable mc
			;;
			*)
				echo "To enable manually, run 'systemctl enable mc'"
			;;
		esac
	;;
	*)
		echo "To install manually, copy or link '$dir/mc.service' to a systemd service directory."
	;;
esac