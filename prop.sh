#!/usr/bin/env sh
# prop.sh: Gets the value of the given property from server.properties

grep -E "^[^#]+" "server.properties" | grep -E "^[[:space:]]*$1[[:space:]]*=" | cut -d= -f2-