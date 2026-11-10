#!/bin/sh
# check for changes to installed packages
# requires: docker-build.sh

DOCKER_RUN='docker run --rm --entrypoint sh'
IMAGE='nasmail:dev'
COMMAND='apk list --no-cache --installed --manifest'
SNAPSHOT='snapshot-apk.txt'

if command -v colordiff >/dev/null 2>&1
then
	DIFF='colordiff'
else
	DIFF='diff'
fi

[ -f "$SNAPSHOT" ] || touch "$SNAPSHOT"

if ! $DOCKER_RUN "$IMAGE" -c "$COMMAND" | $DIFF -u "$SNAPSHOT" -
then
	echo "snapshot using: $DOCKER_RUN $IMAGE -c '$COMMAND' >$SNAPSHOT"
	echo "$DOCKER_RUN $IMAGE -c '$COMMAND' >$SNAPSHOT" | pbcopy
	exit 1
fi
