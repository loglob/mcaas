# mcaas
Minecraft as a (systemD) service

A loose collection of scripts for hosting a minecraft server, including a systemD service.

## How to use
Download the install script (install.sh), make it executable and run it.
By specifying a directory as first argument, it will install to that directory rather than the default _/srv/mc_.

You will be asked if you want to generate a service file. The unit will be named _mc_.

If you generated a service file and want the server to start automatically with the system, run

```systemctl enable mc```

## The scripts
### backup.sh
Creates a timestamped .zip archive of world/
and stores it in bak/

### exec.sh
Sends its arguments to the server as a command.

### echo.sh
Echoes all its arguments as a chat message.
If no arguments are given, echoes STDIN line for line

### restore.sh
Restores the world/ directory from the latest backup created with backup.sh

### start.sh
Starts the server. Doesn't exit until the server exits.

### stop.sh
Stops the currently running server.
Doesn't wait until the server is completely shut down.

### update.sh
Looks for the newest Fabric and Minecraft server release and downloads it to fabric-server-launcher.jar and server.jar

### install.sh
Sets up a minecraft server and downloads all required components.
Optionally generates a systemd service file.

## Configuration
mcaas can be configured via jre_args.
The contents of jre_args are passed to the JRE as arguments when starting the server.
