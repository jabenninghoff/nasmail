# nasmail

Lightweight container optimized for NAS hosted private or archived mail.

Inspired by [ServerContainers/minimail](https://github.com/ServerContainers/minimail).

## Postfix

Postfix uses a configuration based on minimail, with help from [Ubuntu](https://documentation.ubuntu.com/server/how-to/mail-services/install-postfix/) and [Arch](https://wiki.archlinux.org/title/Virtual_user_mail_system_with_Postfix,_Dovecot_and_Roundcube) documentation for integration with Dovecot.

The static configuration enables use of Dovecot SASL, requires TLS encryption for SASL authentication, trusts SASL authenticated users, directs mail logs to standard output (customary on Docker), and adds a TLS encrypted [MSA](https://en.wikipedia.org/wiki/Message_submission_agent) on port 587.

The image exports SMTP (25) and submission (587).

**TODO:** add users, aliases, virtual mailboxes, hostname, domains, TLS configuration. Disallow relaying email.
