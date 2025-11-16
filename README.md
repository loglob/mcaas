# mcaas
Minecraft as a (systemD) service

A loose collection of scripts for hosting a minecraft fabric server, including a systemD service.

## How to use
Run the install script:
```sh
	sh -c "$(wget "https://raw.githubusercontent.com/loglob/mcaas/master/install.sh" -O -)"
```

You will be asked for a directory to install the server into.

A unit file will be generated in the install directory. You will be asked if you want to automatically install and enable it.

> [!CAUTION]
> You should run this service under an unprivileged user.
> If a user named `minecraft` exists, it will be used.
> To use a different user, pass it via the `service_user` environment variable

The install script enables RCON and the management scripts will only work properly with RCON enabled.

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
