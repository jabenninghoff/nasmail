#!/bin/sh
# run all image tests
# requires: docker-build.sh

./apk-list.sh && \
./postconf-defaults.sh && \
./postconf.sh && \
./startup.sh && \
./docker-header.sh && \
printf "\nall tests \e[32mpassed\e[0m!\n"
