#!/bin/sh
# requires: updated snapshot-apk.txt
# build Dockerfile version header

[ -x /usr/bin/pbcopy ] && grep -E 'dovecot|postfix|runit' snapshot-apk.txt | grep -v lmtpd | xargs | sed 's/^/# /' | pbcopy
