#!/bin/sh
# requires: updated snapshot-apk.txt
# build Dockerfile version header

if command -v pbcopy >/dev/null 2>&1
then
	grep -E 'dovecot|postfix|runit' snapshot-apk.txt | grep -v lmtpd | xargs | sed 's/^/# /' | pbcopy
fi
