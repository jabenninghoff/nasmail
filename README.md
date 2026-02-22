# nasmail

Lightweight container optimized for NAS hosted private or archived mail.

Inspired by [ServerContainers/minimail](https://github.com/ServerContainers/minimail).

## Environment Variables

- MAIL_HOST: fully qualified domain name, defaults to nasmail.local
- TLS_KEY: private key, in PEM format
- TLS_CERT: public certificate, in PEM format

TLS_KEY and TLS_CERT must both be set to enable TLS. As the `docker-mailserver` [documentation](https://docker-mailserver.github.io/docker-mailserver/latest/config/security/ssl/#example-using-lets-encrypt-certificates-with-a-synology-nas) notes, Synology NAS generated Let's Encrypt certificates are added with a random directory name under `/usr/syno/etc/certificate/_archive/`. Identify the correct directory name and add the following to `compose.yaml`:

```yaml
volumes:
  - /usr/syno/etc/certificate/_archive/<directory>:/opt/tls
environment:
  - TLS_KEY=/opt/tls/privkey.pem
  - TLS_CERT=/opt/tls/fullchain.pem
```

## Postfix

Postfix uses a configuration based on minimail, with help from [Ubuntu](https://documentation.ubuntu.com/server/how-to/mail-services/install-postfix/) and [Arch](https://wiki.archlinux.org/title/Virtual_user_mail_system_with_Postfix,_Dovecot_and_Roundcube) documentation for integration with Dovecot.

The static configuration enables use of Dovecot SASL, requires TLS encryption for SASL authentication, trusts SASL authenticated users, directs mail logs to standard output (customary on Docker), and adds a TLS encrypted [MSA](https://en.wikipedia.org/wiki/Message_submission_agent) on port 587.

The docker entrypoint script sets the postfix hostname (FQDN) and configures TLS if TLS_KEY and TLS_CERT are set.

The image exports SMTP (25) and submission (587), and the volume `/opt/tls` for accessing certificates.

**TODO:** add users, aliases, virtual mailboxes, domains. Disallow relaying email.
