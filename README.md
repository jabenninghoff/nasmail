# nasmail

Lightweight container optimized for NAS hosted private or archived mail.

Inspired by [ServerContainers/minimail](https://github.com/ServerContainers/minimail).

## Environment Variables

- `MAIL_HOST`: fully qualified domain name, defaults to nasmail.local
- `TLS_KEY`: private key, in PEM format
- `TLS_CERT`: public certificate, in PEM format

`TLS_KEY` and `TLS_CERT` must both be set to enable TLS. As the `docker-mailserver` [documentation](https://docker-mailserver.github.io/docker-mailserver/latest/config/security/ssl/#example-using-lets-encrypt-certificates-with-a-synology-nas) notes, Synology NAS generated Let's Encrypt certificates are added with a random directory name under `/usr/syno/etc/certificate/_archive/`. Identify the correct directory name and add the following to `compose.yaml`:

```yaml
volumes:
  - /usr/syno/etc/certificate/_archive/<directory>:/opt/tls
environment:
  - TLS_KEY=/opt/tls/privkey.pem
  - TLS_CERT=/opt/tls/fullchain.pem
```

## Users

Users are defined in `/opt/users/nasmail-users`, using the [passwd](https://doc.dovecot.org/2.4.2/core/config/auth/databases/passwd_file.html) file format, using the following format:

```passwd
nasmail@nasmail.local:{BLF-CRYPT}$2y$05$hTm9v3j7tLLwKpbpwwCXTOMYwTdmFaARo7MLzXuTrjACToEJ9999y:::postmaster@nasmail.local abuse@nasmail.local:
```

Use `doveadm pw -s BLF-CRYPT` to create the encrypted password using Blowfish. The first field contains the email address of the virtual user, the second contains the password, fields 3-4 (uid,gid) are blank, and field 5 (gecos) contains a list of aliases, including the domain name. The postfix `vmailbox` and `virtual` (alias) files are dynamically built from `nasmail-users` on launch.

The email address or alias `postmaster` must be set for each domain - if it is not, nasmail will automatically assign the alias to the first email in the file for that domain.

## Postfix

Postfix uses a configuration based on minimail, with help from [Ubuntu](https://documentation.ubuntu.com/server/how-to/mail-services/install-postfix/) and [Arch](https://wiki.archlinux.org/title/Virtual_user_mail_system_with_Postfix,_Dovecot_and_Roundcube) documentation for integration with Dovecot.

The static configuration enables Dovecot SASL, directs mail logs to standard output (customary on Docker), disables local mail, enables virtual mail (and aliases) using Dovecot, and adds a [MSA](https://en.wikipedia.org/wiki/Message_submission_agent) on port 587.

The docker entrypoint script sets the Postfix hostname (FQDN), parses `nasmail-users` to create virtual users, aliases, and domains, and configures TLS if `TLS_KEY` and `TLS_CERT` are set. If using TLS, the script requires TLS encryption for SASL authentication and the MSA.

The image exports SMTP (25) and submission (587), and the volumes `/opt/tls` (for certificates) and `/opt/users` (for users).
