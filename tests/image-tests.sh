#!/bin/sh
# run all image tests
# requires: docker-build.sh

# TODO: consider automated test suite similar to https://github.com/ServerContainers/minimail

./apk-list.sh && \
./postconf-defaults.sh && \
./postconf.sh && \
./startup.sh && \
./docker-header.sh && \
./apk-upgrade.sh && \
printf "\nall tests \e[32mpassed\e[0m!\n"
