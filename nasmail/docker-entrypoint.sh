#!/bin/sh

entrypoint_log() {
    echo "$(date -Iseconds) ${MAIL_HOST} nasmail/docker-entrypoint: $*"
}

if [ -z "${MAIL_HOST}" ]
then
    MAIL_HOST='nasmail.local'
    entrypoint_log "MAIL_HOST not set, using default ${MAIL_HOST}"
fi

entrypoint_log "starting with hostname ${MAIL_HOST}"
postconf -e "myhostname = ${MAIL_HOST}"

# TLS
if [ -n "${TLS_KEY}" ] && [ -n "${TLS_CERT}" ]
then
    entrypoint_log "configuring TLS"
    postconf -e 'smtp_tls_security_level = may'
    postconf -e 'smtpd_tls_security_level = may'
    postconf -e "smtpd_tls_chain_files = ${TLS_KEY},${TLS_CERT}"
    postconf -e 'smtp_tls_loglevel = 1'
    postconf -e 'smtpd_tls_loglevel = 1'
    postconf -e 'smtpd_tls_received_header = yes'
    # secure auth and submission
    postconf -e 'smtpd_tls_auth_only = yes'
    postconf -M submission/inet='submission inet n - n - - smtpd -o smtpd_tls_security_level=encrypt'
else
    entrypoint_log "warning - TLS_KEY or TLS_CERT not set, TLS disabled"
fi

exec "$@"
