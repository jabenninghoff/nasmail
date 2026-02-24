#!/bin/sh

cat <<'EOF'
# Test that Postfix accepts mail for defined virtual users and aliases only
# requires email: nasmail@nasmail.test, aliases: postmaster@nasmail.test, abuse@nasmail.test
# other recipients should be rejected with error 550 or 454

EHLO localhost
HELO localhost
MAIL From: nobody@example.com

# these should be accepted
RCPT To: nasmail@nasmail.test
RCPT To: postmaster@nasmail.test
RCPT To: abuse@nasmail.test

# these should be rejected
RCPT To: nobody@nasmail.test
RCPT To: nasmail@mail.nasmail.test
RCPT To: nobody@example.com

DATA
Subject: Test email
This is a test email.
.
QUIT

EOF
telnet mail.nasmail.test 25
