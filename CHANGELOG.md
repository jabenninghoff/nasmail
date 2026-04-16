# Changelog

## [1.1.2](https://github.com/jabenninghoff/nasmail/compare/v1.1.1...v1.1.2) (2026-04-16)


### Bug Fixes

* upgrade alpine to 3.23.4 ([e391ff9](https://github.com/jabenninghoff/nasmail/commit/e391ff9284d5a85ac1b12cec710467328a0eff20))

## [1.1.1](https://github.com/jabenninghoff/nasmail/compare/v1.1.0...v1.1.1) (2026-04-13)


### Bug Fixes

* bump docker/login-action from 4.0.0 to 4.1.0 ([96585ab](https://github.com/jabenninghoff/nasmail/commit/96585ab81592dcbad8987810b1112f5260c9115b))
* bump googleapis/release-please-action from 4.4.0 to 4.4.1 ([164bfef](https://github.com/jabenninghoff/nasmail/commit/164bfefcc06aeba955b6d315fe9bbb744c7c4e95))
* update dovecot to 2.4.3-r1 ([5f4833a](https://github.com/jabenninghoff/nasmail/commit/5f4833af70c22933ae8dddebdf6d5e22c3de8113))

## [1.1.0](https://github.com/jabenninghoff/nasmail/compare/v1.0.4...v1.1.0) (2026-03-31)


### Features

* upgrade dovecot from 2.4.2 to 2.4.3 ([8e5800b](https://github.com/jabenninghoff/nasmail/commit/8e5800b394616f2564f597de4b98269b2cb82752))


### Bug Fixes

* add Dependabot version updates ([f7ea964](https://github.com/jabenninghoff/nasmail/commit/f7ea9646ca07f50b8e3c0c3675f61708c51f35cd))
* pin GitHub actions to improve security ([2012ca8](https://github.com/jabenninghoff/nasmail/commit/2012ca8134d17726ea0f0a24e24c783b79613bd4))
* update docker GitHub Actions ([f19e5c8](https://github.com/jabenninghoff/nasmail/commit/f19e5c87f46b5fc6bd370fed3160b1c1a729fc15))

## [1.0.4](https://github.com/jabenninghoff/nasmail/compare/v1.0.3...v1.0.4) (2026-03-13)


### Bug Fixes

* add nasmail version build argument ([a558837](https://github.com/jabenninghoff/nasmail/commit/a5588376c22e2d017ff1363a24c10c96e18db2e0))
* automate version with version.txt ([10f207c](https://github.com/jabenninghoff/nasmail/commit/10f207cd04411a5d7449f7b859f7e0aa39a7034e))
* upgrade base packages in image ([66ac126](https://github.com/jabenninghoff/nasmail/commit/66ac1260fdbd886b848208d98eb36bff2a02910b))

## [1.0.3](https://github.com/jabenninghoff/nasmail/compare/v1.0.2...v1.0.3) (2026-02-26)


### Bug Fixes

* log nasmail version at startup ([a184393](https://github.com/jabenninghoff/nasmail/commit/a1843936237af6a170fef791a8cfb451244cd1c0))

## [1.0.2](https://github.com/jabenninghoff/nasmail/compare/v1.0.1...v1.0.2) (2026-02-25)

Remove [release-please-action](https://github.com/googleapis/release-please-action) as it is preventing proper release tagging somehow. Release manually until resolved.

## [1.0.1](https://github.com/jabenninghoff/nasmail/compare/v1.0.0...v1.0.1) (2026-02-25)

Bootstrap release, switch `compose.yaml` to use implicit `latest` tag instead of `main`.

### Bug Fixes

* add missing postconf test ([b67a2ad](https://github.com/jabenninghoff/nasmail/commit/b67a2ad23bb6636d4bc08dd455d049f4ebc75418))
* improved postfix snapshot test ([719cfe3](https://github.com/jabenninghoff/nasmail/commit/719cfe30bf358c87bf6cd10ac6e3040e883b2b36))

## [1.0.0](https://github.com/jabenninghoff/nasmail/tree/v1.0.0) (2026-02-25)

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
