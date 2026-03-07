#!/bin/sh
# local build wrapper
set -e

docker compose build --build-arg NASMAIL_VERSION="$(cat version.txt)" "$@"
