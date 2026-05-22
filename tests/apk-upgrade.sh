#!/bin/sh
# check for apk package updates
# requires: docker-build.sh
LATEST='ghcr.io/jabenninghoff/nasmail:latest'
DEV='nasmail:dev'

check_apk_upgrade() {
    image="$1"
    UPGRADEABLE=$(docker run --rm --entrypoint sh "$image" -c 'apk update -q && apk list --upgradeable')
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
docker pull -q "$LATEST" >/dev/null

check_apk_upgrade "$LATEST"
[ "$(docker images -q "$DEV")" ] && check_apk_upgrade "$DEV"
