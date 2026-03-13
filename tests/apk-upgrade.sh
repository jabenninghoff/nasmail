#!/bin/sh
# check for apk package updates
# requires: docker-build.sh

echo "apk-upgrade: pulling latest image from ghcr.io/jabenninghoff/nasmail:latest"
docker pull ghcr.io/jabenninghoff/nasmail:latest

echo ""
echo "apk-upgrade: running apk upgrade --no-cache in ghcr.io/jabenninghoff/nasmail:latest"
docker run --rm --entrypoint apk ghcr.io/jabenninghoff/nasmail:latest upgrade --no-cache

echo ""
echo "apk-upgrade: running apk upgrade --no-cache in nasmail:dev"
docker run --rm --entrypoint apk nasmail:dev upgrade --no-cache
