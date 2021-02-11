#!/usr/bin/env sh
# prop.sh: Gets the value of the given property from server.properties

egrep "^[^#]+" "server.properties" | egrep "^[[:space:]]*$1[[:space:]]*=" | cut -d= -f2-