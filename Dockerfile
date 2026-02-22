FROM alpine

RUN apk add --no-cache runit postfix dovecot dovecot-lmtpd && \
    mkdir -p /opt/tls

# Postfix static configuration
RUN postconf -e 'smtpd_sasl_type = dovecot' && \
    postconf -e 'smtpd_sasl_path = private/auth' && \
    postconf -e 'smtpd_sasl_auth_enable = yes' && \
    postconf -e 'smtpd_recipient_restrictions =  permit_mynetworks permit_sasl_authenticated reject_unauth_destination' && \
    postconf -e 'maillog_file = /dev/stdout' && \
    postconf -M submission/inet='submission inet n - n - - smtpd' && \
    postconf -e 'alias_maps ='

COPY nasmail/ /opt/nasmail/

# Postfix (smtp, submission)
EXPOSE 25 587

VOLUME [ "/opt/tls" ]

ENTRYPOINT [ "/opt/nasmail/docker-entrypoint.sh" ]
CMD [ "postfix", "start-fg" ]
