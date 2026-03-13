#!/bin/sh
# check for apk package updates
# requires: docker-build.sh

echo "checking ghcr.io/jabenninghoff/nasmail:latest"
docker run --rm --entrypoint apk ghcr.io/jabenninghoff/nasmail:latest upgrade --no-cache

echo ""
echo "checking nasmail:dev"
docker run --rm --entrypoint apk nasmail:dev upgrade --no-cache
