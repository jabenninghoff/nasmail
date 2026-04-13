FROM alpine:3.23

# runit 2.3.0-r0 postfix 3.10.8-r0 dovecot 2.4.3-r1
RUN apk upgrade --no-cache && apk add --no-cache runit postfix dovecot dovecot-lmtpd

ARG NASMAIL_VERSION
ENV NASMAIL_VERSION="${NASMAIL_VERSION}"
COPY nasmail/ /opt/nasmail/

# Postfix static configuration
RUN mkdir -p /opt/tls /opt/users && \
    postconf -e 'smtpd_sasl_type = dovecot' && \
    postconf -e 'smtpd_sasl_path = private/auth' && \
    postconf -e 'smtpd_sasl_auth_enable = yes' && \
    # TODO: workaround for https://bugzilla.mozilla.org/show_bug.cgi?id=538809
    postconf -e 'smtpd_forbid_unauth_pipelining = no' && \
    postconf -e 'maillog_file = /dev/stdout' && \
    postconf -e 'alias_maps =' && \
    # don't deliver to local mailboxes, only virtual mailboxes
    postconf -e 'mydestination =' && \
    postconf -e 'virtual_mailbox_maps = texthash:/etc/postfix/vmailbox' && \
    postconf -e 'virtual_alias_maps = texthash:/etc/postfix/virtual' && \
    postconf -e 'virtual_transport = lmtp:unix:private/dovecot-lmtp' && \
    postconf -M submission/inet='submission inet n - n - - smtpd'

# Postfix (smtp, submission)
EXPOSE 25 587
VOLUME [ "/opt/tls", "/opt/users" ]

# Dovecot static configuration
RUN mv -f /opt/nasmail/dovecot.conf /etc/dovecot/dovecot.conf && \
    mkdir -p /var/vmail && \
    addgroup --gid 5000 dockervmail && \
    adduser --ingroup dockervmail --uid 5000 --home /var/vmail --shell /bin/false --disabled-password --gecos "" dockervmail

# Dovecot (imap, imaps)
EXPOSE 143 993
VOLUME [ "/var/vmail" ]

ENTRYPOINT [ "/opt/nasmail/docker-entrypoint.sh" ]
CMD [ "runsvdir", "-P", "/opt/nasmail/runit" ]
