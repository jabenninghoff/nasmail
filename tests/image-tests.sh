#!/bin/sh
# run all image tests
# requires: docker-build.sh
./apk-list.sh && \
./postconf-defaults.sh && \
./postconf.sh && \
./apk-upgrade.sh && \
./startup.sh && \
echo "" && echo "all tests passed!"
