#!/bin/sh
# check for changes to postconf default configuration
docker run -it --rm --entrypoint postconf ghcr.io/jabenninghoff/nasmail:main | colordiff -u snapshot-postconf.txt -

echo 'snapshot using: docker run -it --rm --entrypoint postconf ghcr.io/jabenninghoff/nasmail:main >snapshot-postconf.txt'
echo 'docker run -it --rm --entrypoint postconf ghcr.io/jabenninghoff/nasmail:main >snapshot-postconf.txt' | pbcopy
