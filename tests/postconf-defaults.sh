#!/bin/sh
# check for changes to postconf default configuration
# requires: docker build -t nasmail .
docker run --rm --entrypoint postconf nasmail -d | colordiff -u snapshot-postconf-defaults.txt -

echo 'snapshot using: docker run --rm --entrypoint postconf nasmail -d >snapshot-postconf-defaults.txt'
echo 'docker run --rm --entrypoint postconf nasmail -d >snapshot-postconf-defaults.txt' | pbcopy
