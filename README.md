# mcaas
Minecraft as a (systemD) service

A loose collection of scripts for hosting a minecraft fabric server, including a systemD service.

## How to use
Download the install script (install.sh), make it executable and run it.
```sh
	wget "https://raw.githubusercontent.com/loglob/mcaas/master/install.sh" -v -O mcaas.sh
	./mcaas.sh # custom install directory here
	rm mcaas.sh
```

By specifying a directory as first argument, it will install to that directory rather than the default _/srv/mc_.

A unit file will be generated in the install directory. You will be asked if you want to autmatically install and enable it.

Note that RCON needs to be enabled and properly configured before the service can be used. To do so, edit these entries in server.properties:
 * rcon.port
 * rcon.password
 * enable-rcon

After installing, the server can be started and stopped by running `service mc start` and `service mc stop`.

## The scripts
### backup.sh
Creates a timestamped .zip archive of `world/`
and stores it in `bak/`.

### exec.sh
Sends its arguments to the server as a command.

### echo.sh
Echoes all its arguments as a chat message.
If no arguments are given, echoes STDIN line for line.

### restore.sh
Restores the `world/` directory from the latest backup created with backup.sh.

### start.sh
Starts the server. Doesn't exit until the server exits.

### stop.sh
Stops the currently running server.
Waits until the server is completely shut down.

### update.sh
Looks for the newest Fabric and Minecraft server release and downloads it to fabric-server-launcher.jar and server.jar

### install.sh
Sets up a minecraft server and downloads all required components.
Optionally generates a systemd service file.

## Configuration
mcaas can be configured via the `jre_args` file located in the install directory.
The contents of jre_args are passed to the JRE as arguments when starting the server.
