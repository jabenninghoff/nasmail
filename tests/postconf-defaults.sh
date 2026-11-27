#!/bin/sh
# check for changes to postconf default configuration
# requires: docker-build.sh

DOCKER_RUN='docker run --rm --hostname nasmail.test --entrypoint sh'
IMAGE='nasmail:dev'
COMMAND='postconf -d'
SNAPSHOT='snapshot-postconf-defaults.txt'

if command -v colordiff >/dev/null 2>&1
then
	DIFF='colordiff'
else
	DIFF='diff'
fi

[ -f "$SNAPSHOT" ] || touch "$SNAPSHOT"

if ! $DOCKER_RUN "$IMAGE" -c "$COMMAND" | "$DIFF" -u "$SNAPSHOT" -
then
	echo "snapshot using: $DOCKER_RUN $IMAGE -c '$COMMAND' >$SNAPSHOT"
	if command -v pbcopy >/dev/null 2>&1
	then
		echo "$DOCKER_RUN $IMAGE -c '$COMMAND' >$SNAPSHOT" | pbcopy
	fi
	exit 1
fi
