#!/bin/sh
# interactive: check nasmail postfix configuration
# requires: docker compose, swaks

fail() {
    printf "\nMail recipients tests \e[31mFAILED\e[0m\n\n"
    docker compose down -v
    exit 1
}

mail_to() {
    rcpt=$1
    result=$2
    printf "trying RCPT To: %s (%s)\n" "$rcpt" "$result"
    if swaks --server mail.nasmail.test --quit-after RCPT --from nasmail@nasmail.test --to "$rcpt" --no-hints --silent 2
    then
        [ "$result" = "expect_succeed" ] || fail
    else
        [ "$result" = "expect_fail" ] || fail
    fi
}

docker compose up -d && printf "\nwaiting 3 seconds for mail server to start..." && sleep 3
printf "done!\n\n"

printf "Checking EHLO response..."
EHLO_EXPECTED=$(cat <<'EOF'
220 mail.nasmail.test ESMTP Postfix
250-mail.nasmail.test
250-PIPELINING
250-SIZE 10240000
250-VRFY
250-ETRN
250-STARTTLS
250-ENHANCEDSTATUSCODES
250-8BITMIME
250-DSN
250-SMTPUTF8
250 CHUNKING
221 2.0.0 Bye
EOF
)

EHLO_RESPONSE="$(swaks --server mail.nasmail.test --quit-after EHLO --no-hints --hide-send --hide-informational)" || fail
[ "$EHLO_RESPONSE" = "$EHLO_EXPECTED" ] || fail
printf "OK\n"

printf "Checking TLS..."
EHLO_EXPECTED=$(cat <<'EOF'
220 mail.nasmail.test ESMTP Postfix
250-mail.nasmail.test
250-PIPELINING
250-SIZE 10240000
250-VRFY
250-ETRN
250-STARTTLS
250-ENHANCEDSTATUSCODES
250-8BITMIME
250-DSN
250-SMTPUTF8
250 CHUNKING
220 2.0.0 Ready to start TLS
250-mail.nasmail.test
250-PIPELINING
250-SIZE 10240000
250-VRFY
250-ETRN
250-AUTH PLAIN LOGIN
250-ENHANCEDSTATUSCODES
250-8BITMIME
250-DSN
250-SMTPUTF8
250-CHUNKING
250 REQUIRETLS
221 2.0.0 Bye
EOF
)
EHLO_RESPONSE="$(swaks --server mail.nasmail.test --tls --quit-after EHLO --no-hints --hide-send --hide-informational)" || fail
[ "$EHLO_RESPONSE" = "$EHLO_EXPECTED" ] || fail
printf "OK\n"

printf "\nMail recipients: testing RCPT To:\n"
mail_to nasmail@nasmail.test          expect_succeed
mail_to postmaster@nasmail.test       expect_succeed
mail_to abuse@nasmail.test            expect_succeed
mail_to nobody@nasmail.test           expect_fail
mail_to nasmail@mail.nasmail.test     expect_fail
mail_to nobody@example.com            expect_fail
mail_to root@mail.nasmail.test        expect_fail
mail_to root@nasmail.test             expect_fail
mail_to dockervmail@mail.nasmail.test expect_fail
mail_to dockervmail@nasmail.test      expect_fail
printf "\n"

printf "Mail recipients tests \e[32msuccessful\e[0m!\n\n"
docker compose down -v
