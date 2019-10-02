# mcaas
Minecraft as a (systemD) service

A loose collection of scripts for hosting a minecraft server, including a systemD service.

## How to use
Choose a server directory and cd into it. /srv/mc/ is the default but you can use whatever you want (but read the note below when using a custom directory and systemD service interface).
All paths in this documentation are relative to this server directory.
```
  mkdir /srv/mc/
  cd /srv/mc/
```
Clone the script into your server directory. 

```git clone https://github.com/loglob/mcaas .```

Then run

```update.sh```

to download the newest Minecraft Server Jar, or place your own custom .jar in minecraft_server.jar

You can now start the server with

```start.sh```

which will create a screen session named 'mc-screen' through which you can directly interact with the server. Use

```stop.sh```

to stop the server.

If you prefer the SystemD service interface, copy /srv/mc/mc.service
to any SystemD service directory ( /{lib,run,etc}/systemd/system ) and
use ```service mc start``` and ```service mc stop``` instead.

If you want the server to start automatically with the system, run

```systemctl enable mc```

### note:
If you didn't put the scripts in /srv/mc and want to use the systemD service, you need to edit lines 7 and 8 to reference the correct scripts (replace /srv/mc/ with the absolute path to your directory)

## The scripts
### backup.sh
Creates a timestamped .zip archive of world/
and stores it in bak/

### exec.sh
Sends its arguments to the server as a command.

### restore.sh
Restores the world/ directory from the latest backup created with backup.sh

### start.sh
Starts the server in a new screen session

### stop.sh
Stops the currently running server and closes its screen session

### update.sh
Looks for the newest Minecraft server release and downloads it to /srv/mc/minecraft_server.sh
Also makes sure the directories bak/ and world/ exist and automatically accepts the EULA

## Configuration
mcaas can be configured via the files found in conf/

### jre_args
The contents of jre_args are passed as arguments to the JRE when starting the server.

### screen_session
The contents of screen_session are used as the session name for the screen session mcaas creates.
