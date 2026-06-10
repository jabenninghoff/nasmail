#!/bin/sh
# local build wrapper
set -e

docker build --build-arg NASMAIL_VERSION="$(cat version.txt | tr -d '[:space:]')" -t nasmail:dev "$@" .
