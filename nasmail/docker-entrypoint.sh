#!/bin/sh

entrypoint_log() {
    # match format of postfix, dovecot logs
    echo "$(date '+%b %d %H:%M:%S') nasmail: $*"
}

if [ -z "${MAIL_HOST}" ]
then
    MAIL_HOST='nasmail.local'
    entrypoint_log "warning: MAIL_HOST not set, using default hostname ${MAIL_HOST}"
fi

entrypoint_log "using hostname ${MAIL_HOST}"
postconf -e "myhostname = ${MAIL_HOST}"

if [ ! -f '/opt/users/nasmail-users' ]
then
    entrypoint_log "warning: /opt/users/nasmail-users not found, using default credentials 'nasmail@nasmail.local:nasmail'"
    # shellcheck disable=SC2016
    echo 'nasmail@nasmail.local:{BLF-CRYPT}$2y$05$hTm9v3j7tLLwKpbpwwCXTOMYwTdmFaARo7MLzXuTrjACToEJ9999y:' > /opt/users/nasmail-users
fi

# parse nasmail-users and generate postfix maps
rm /etc/postfix/vmailbox /etc/postfix/virtual 2>/dev/null
while IFS=: read -r email _ _ _ aliases _
do
    entrypoint_log "adding user ${email}"
    echo "${email} vmail" >> /etc/postfix/vmailbox
    echo "${email}" >> /tmp/all-emails
    for alias in ${aliases}
    do
        entrypoint_log "adding alias ${alias} for ${email}"
        echo "${alias} ${email}" >> /etc/postfix/virtual
        echo "${alias}" >> /tmp/all-emails
    done
done </opt/users/nasmail-users

# extract unique email domains and configure postfix
EMAIL_DOMAINS=$(awk -F@ '{print $2}' /tmp/all-emails | sort -u | xargs)
entrypoint_log "using domains ${EMAIL_DOMAINS}"
postconf -e "virtual_mailbox_domains = ${EMAIL_DOMAINS}"

# ensure postmaster exists for each domain
for domain in ${EMAIL_DOMAINS}
do
    postmaster="$(grep ^postmaster@${domain} /tmp/all-emails | head -n 1)"
    if [ -z "${postmaster}" ]
    then
        email="$(grep @${domain} /tmp/all-emails | head -n 1)"
        entrypoint_log "warning: no postmaster found for domain ${domain}, using ${email}"
        echo "postmaster@${domain} ${email}" >> /etc/postfix/virtual
        echo "postmaster@${domain}" >> /tmp/all-emails
    fi
done

# use first postmaster for dovecot
dovecot_postmaster="$(grep ^postmaster@ /tmp/all-emails | head -n 1)"
entrypoint_log "using dovecot postmaster ${dovecot_postmaster}"
echo "postmaster_address = ${dovecot_postmaster}" >> /etc/dovecot/dovecot.conf

rm /tmp/all-emails

# TLS
if [ -n "${TLS_KEY}" ] && [ -n "${TLS_CERT}" ]
then
    entrypoint_log "enabling TLS"
    postconf -e 'smtp_tls_security_level = may'
    postconf -e 'smtpd_tls_security_level = may'
    postconf -e "smtpd_tls_chain_files = ${TLS_KEY},${TLS_CERT}"
    postconf -e 'smtp_tls_loglevel = 1'
    postconf -e 'smtpd_tls_loglevel = 1'
    postconf -e 'smtpd_tls_received_header = yes'
    # secure auth and submission
    postconf -e 'smtpd_tls_auth_only = yes'
    postconf -M submission/inet='submission inet n - n - - smtpd -o smtpd_tls_security_level=encrypt'
    # dovecot TLS config
    echo "ssl_server_key_file = ${TLS_KEY}" >> /etc/dovecot/dovecot.conf
    echo "ssl_server_cert_file = ${TLS_CERT}" >> /etc/dovecot/dovecot.conf
else
    entrypoint_log "warning: TLS_KEY or TLS_CERT not set, TLS disabled"
fi

exec "$@"
