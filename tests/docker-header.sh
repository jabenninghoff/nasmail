#!/bin/sh
# requires: updated snapshot-apk.txt
# build Dockerfile version header

grep -E 'dovecot|postfix|runit' snapshot-apk.txt | grep -v lmtpd | xargs | sed 's/^/# /' | pbcopy
