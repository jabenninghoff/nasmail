FROM alpine

RUN apk add --no-cache runit postfix dovecot dovecot-lmtpd

RUN mkdir -p /opt/tls /opt/users

# Postfix static configuration
RUN postconf -e 'smtpd_sasl_type = dovecot' && \
    postconf -e 'smtpd_sasl_path = private/auth' && \
    postconf -e 'smtpd_sasl_auth_enable = yes' && \
    postconf -e 'maillog_file = /dev/stdout' && \
    postconf -e 'alias_maps =' && \
    postconf -e 'mydestination =' && \
    postconf -e 'virtual_mailbox_maps = texthash:/etc/postfix/vmailbox' && \
    postconf -e 'virtual_alias_maps = texthash:/etc/postfix/virtual' && \
    postconf -e 'virtual_transport = lmtp:unix:private/dovecot-lmtp' && \
    postconf -M submission/inet='submission inet n - n - - smtpd'

COPY nasmail/ /opt/nasmail/

# Postfix (smtp, submission)
EXPOSE 25 587

VOLUME [ "/opt/tls", "/opt/users" ]

ENTRYPOINT [ "/opt/nasmail/docker-entrypoint.sh" ]
CMD [ "postfix", "start-fg" ]
