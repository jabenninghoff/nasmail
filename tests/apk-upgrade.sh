#!/bin/sh
# check for apk package updates
# requires: docker-build.sh
LATEST='ghcr.io/jabenninghoff/nasmail:latest'
DEV='nasmail:dev'

die() {
    echo "$1" >&2
    exit 1
}

check_apk_upgrade() {
    image="$1"
    UPGRADEABLE=$(docker run --rm --entrypoint sh "$image" -c 'apk update -q && apk list --upgradeable') || die "apk-upgrade: failed to check for updates in $image"
    if [ -z "$UPGRADEABLE" ]
    then
        echo "apk-upgrade: no updates available for $image"
    else
        echo "apk-upgrade: updates available for $image:"
        echo "$UPGRADEABLE"
        exit 1
    fi
}

echo "apk-upgrade: pulling latest image from $LATEST" 
docker pull -q "$LATEST" >/dev/null || die "apk-upgrade: failed to pull latest image from $LATEST"

check_apk_upgrade "$LATEST"
if [ -z "$(docker images -q "$DEV")" ]
then
    echo "apk-upgrade: no local image found for $DEV, skipping check"
else
    check_apk_upgrade "$DEV"
fi
