#!/bin/sh
# check for changes to postconf default configuration
# requires:  docker build -t nasmail .
docker run --rm --entrypoint postconf nasmail | colordiff -u snapshot-postconf.txt -

echo 'snapshot using: docker run --rm --entrypoint postconf nasmail >snapshot-postconf.txt'
echo 'docker run --rm --entrypoint postconf nasmail >snapshot-postconf.txt' | pbcopy
