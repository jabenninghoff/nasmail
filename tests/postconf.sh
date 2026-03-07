#!/bin/sh
# check for changes to postconf configuration
# requires: docker-build.sh
docker run --rm --entrypoint postconf nasmail:dev | colordiff -u snapshot-postconf.txt -

echo 'snapshot using: docker run --rm --entrypoint postconf nasmail:dev >snapshot-postconf.txt'
echo 'docker run --rm --entrypoint postconf nasmail:dev >snapshot-postconf.txt' | pbcopy
