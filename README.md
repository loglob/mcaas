# mcaas
Minecraft as a (systemD) service

A loose collection of scripts for hosting a minecraft server, including a systemD service.

## How to use
Download the install script (install.sh), make it executable and run it.
By specifying a directory, it will install to that directory rather than the default /srv/mc

You will be asked if you want to generate a service file.

If you generated a service file and want the server to start automatically with the system, run

```systemctl enable mc```

## The scripts
### backup.sh
Creates a timestamped .zip archive of world/
and stores it in bak/

### exec.sh
Sends its arguments to the server as a command

### restore.sh
Restores the world/ directory from the latest backup created with backup.sh

### start.sh
Starts the server in a new screen session

### stop.sh
Stops the currently running server and closes its screen session.
Blocks until the screen is closed

### update.sh
Looks for the newest Minecraft server release and downloads it to minecraft_server.sh

### install.sh
Sets up a minecraft server and downloads all required components.
Optionally generates a systemd service file.

## Configuration
mcaas can be configured via the files found in conf/

### jre_args
The contents of jre_args are passed as arguments to the JRE when starting the server.

### screen_session
The contents of screen_session are used as the session name for the screen session mcaas creates.
