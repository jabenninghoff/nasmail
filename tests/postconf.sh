#!/bin/sh
# check for changes to postconf configuration
# requires: docker-build.sh
DOCKER_RUN='docker run --rm --hostname nasmail.test --entrypoint sh'
IMAGE='nasmail:dev'
COMMAND='postconf'
SNAPSHOT='snapshot-postconf.txt'

[ -f "$SNAPSHOT" ] || touch "$SNAPSHOT"

if ! $DOCKER_RUN "$IMAGE" -c "$COMMAND" | colordiff -u "$SNAPSHOT" -
then
	echo "snapshot using: $DOCKER_RUN $IMAGE -c '$COMMAND' >$SNAPSHOT"
	echo "$DOCKER_RUN $IMAGE -c '$COMMAND' >$SNAPSHOT" | pbcopy
    exit 1
fi
