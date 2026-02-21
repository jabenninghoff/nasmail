FROM alpine

RUN apk add --no-cache runit postfix dovecot dovecot-lmtpd

# Postfix static configuration
RUN postconf -e 'smtpd_sasl_type = dovecot' && \
    postconf -e 'smtpd_sasl_path = private/auth' && \
    postconf -e 'smtpd_sasl_auth_enable = yes' && \
    postconf -e 'smtpd_tls_auth_only = yes' && \
    postconf -e 'smtpd_recipient_restrictions =  permit_mynetworks permit_sasl_authenticated reject_unauth_destination' && \
    postconf -e 'maillog_file = /dev/stdout' && \
    postconf -M submission/inet='submission inet n - n - - smtpd -o smtpd_tls_security_level=encrypt' && \
    postconf -e 'alias_maps ='

# Postfix (smtp, submission)
EXPOSE 25 587
