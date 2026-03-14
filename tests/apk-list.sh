#!/bin/sh
# check for changes to installed packages
# requires: docker-build.sh
docker run --rm --entrypoint apk nasmail:dev list | colordiff -u snapshot-apk.txt -

echo 'snapshot using: docker run --rm --entrypoint apk nasmail:dev list >snapshot-apk.txt'
echo 'docker run --rm --entrypoint apk nasmail:dev list >snapshot-apk.txt' | pbcopy
