#!/bin/sh
# check for changes to postconf default configuration
# requires: docker-build.sh
docker run --rm --entrypoint postconf nasmail:dev -d | colordiff -u snapshot-postconf-defaults.txt -

echo 'snapshot using: docker run --rm --entrypoint postconf nasmail:dev -d >snapshot-postconf-defaults.txt'
echo 'docker run --rm --entrypoint postconf nasmail:dev -d >snapshot-postconf-defaults.txt' | pbcopy
