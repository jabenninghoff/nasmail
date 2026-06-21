#!/bin/sh
# run all image tests
# requires: docker-build.sh
./apk-list.sh && \
./postconf-defaults.sh && \
./postconf.sh && \
./docker-header.sh && \
./startup.sh && \
./apk-upgrade.sh && \
echo "" && echo "all tests passed!"
