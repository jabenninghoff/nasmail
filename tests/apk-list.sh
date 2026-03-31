#!/bin/sh
# check for changes to installed packages
# requires: docker-build.sh
docker run --rm --entrypoint apk nasmail:dev list --no-cache --installed --manifest | colordiff -u snapshot-apk.txt -

echo 'snapshot using: docker run --rm --entrypoint apk nasmail:dev list --no-cache --installed --manifest >snapshot-apk.txt'
echo 'docker run --rm --entrypoint apk nasmail:dev list --no-cache --installed --manifest >snapshot-apk.txt' | pbcopy
