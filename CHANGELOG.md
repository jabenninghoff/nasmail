# Changelog

## [1.0.3](https://github.com/jabenninghoff/nasmail/compare/v1.0.2...v1.0.3) (2026-02-26)


### Bug Fixes

* log nasmail version at startup ([a184393](https://github.com/jabenninghoff/nasmail/commit/a1843936237af6a170fef791a8cfb451244cd1c0))

## 1.0.2 (2026-02-25)

Remove [release-please-action](https://github.com/googleapis/release-please-action) as it is preventing proper release tagging somehow. Release manually until resolved.

## 1.0.1 (2026-02-25)

Bootstrap release, switch `compose.yaml` to use implicit `latest` tag instead of `main`.

### Bug Fixes

* add missing postconf test ([b67a2ad](https://github.com/jabenninghoff/nasmail/commit/b67a2ad23bb6636d4bc08dd455d049f4ebc75418))
* improved postfix snapshot test ([719cfe3](https://github.com/jabenninghoff/nasmail/commit/719cfe30bf358c87bf6cd10ac6e3040e883b2b36))

## 1.0.0 (2026-02-25)

Initial release of nasmail, with the following features:

* Postfix SMTP server with mail delivery to (only) virtual users defined in `nasmail-users` and SASL authentication
* Dovecot IMAP server using Maildir++ supporting portable file storage on NAS
* Multiple process management using runit
* Startup configuration and logging using Docker entrypoint script
* Support for TLS encryption of SMTP and IMAP using Synology Let's Encrypt certificates
* Basic tests for SMTP server and Postfix configuration
* Docker compose file and .env file template
* Automated publishing of multi-platform Docker images to GitHub Container Registry

Verified using telnet, Thunderbird and macOS Mail.
