# Changelog

## [1.4.1](https://github.com/jabenninghoff/nasmail/compare/v1.4.0...v1.4.1) (2026-08-03)


### Bug Fixes

* bump actions/attest from 4.1.1 to 4.2.0 ([52a292a](https://github.com/jabenninghoff/nasmail/commit/52a292a53a0fe49c46d556c83d557316171f1311))
* bump actions/checkout from 7.0.0 to 7.0.1 ([2c2e6e9](https://github.com/jabenninghoff/nasmail/commit/2c2e6e98d7a46b47596d8ea9db3549a7c00aaf7f))
* bump docker/login-action from 4.4.0 to 4.5.2 ([04ada8a](https://github.com/jabenninghoff/nasmail/commit/04ada8ab02846de58586c1435ce4e20d8d39a4e2))
* upgrade dovecot to 2.4.4 ([ffd6d29](https://github.com/jabenninghoff/nasmail/commit/ffd6d296bcf5a27b1a1e023fa9076cf298b48ac0))

## [1.4.0](https://github.com/jabenninghoff/nasmail/compare/v1.3.1...v1.4.0) (2026-07-14)

**Important:** for the 1.4.0 release, the filesystem layout and published volumes have changed to better conform to common naming conventions, moving all files under `/opt` to `/opt/nasmail`. There are two breaking changes:

* `/opt/tls` is now `/opt/nasmail/tls`
* `/opt/users` is now `/opt/nasmail/users`

Update your `compose.yaml` accordingly; an example production Compose file has been added to the README.

### Features

* update filesystem layout from nasvcs ([f9ad609](https://github.com/jabenninghoff/nasmail/commit/f9ad609abbae6992efbd71e49a8895452862afae))


### Bug Fixes

* bump actions/attest from 4.1.0 to 4.1.1 ([d347811](https://github.com/jabenninghoff/nasmail/commit/d347811c2e850dc8348ba03ca5b3594cf6754129))
* bump actions/checkout from 6.0.3 to 7.0.0 ([4e24e06](https://github.com/jabenninghoff/nasmail/commit/4e24e06909c6e83490e3b0cfbe742d7efa82bb87))
* bump docker/build-push-action from 7.2.0 to 7.3.0 ([0246e50](https://github.com/jabenninghoff/nasmail/commit/0246e5067bcd1f04e36a5ca96f420ca6206bdd76))
* bump docker/login-action from 4.2.0 to 4.4.0 ([6c9cee4](https://github.com/jabenninghoff/nasmail/commit/6c9cee448ec3cd2ba953f0520644ad0bdffa464b))
* bump docker/metadata-action from 6.1.0 to 6.2.0 ([700b41e](https://github.com/jabenninghoff/nasmail/commit/700b41e5f2b98940520b3c2e4e7deb9d398d85fd))
* bump docker/setup-buildx-action from 4.1.0 to 4.2.0 ([d74db02](https://github.com/jabenninghoff/nasmail/commit/d74db02a53550407ace6179328fc5c7f483067b0))
* bump docker/setup-qemu-action from 4.1.0 to 4.2.0 ([d00f55a](https://github.com/jabenninghoff/nasmail/commit/d00f55ab580193b607b32d645d79ec8cdbcd4a00))
* merge compose and env files ([4edfe81](https://github.com/jabenninghoff/nasmail/commit/4edfe810bc1b1904c43ed682ee93e771cc4f7048))
* upgrade postfix from 3.11.4 to 3.11.5 ([5904712](https://github.com/jabenninghoff/nasmail/commit/59047121ac82eb05306dc67337a3eb1e6c6b051f))

## [1.3.1](https://github.com/jabenninghoff/nasmail/compare/v1.3.0...v1.3.1) (2026-06-20)


### Bug Fixes

* upgrade postfix from 3.11.3 to 3.11.4 ([1c7a865](https://github.com/jabenninghoff/nasmail/commit/1c7a865e79c22b5aab9cd3fda661f099317c3c52))

## [1.3.0](https://github.com/jabenninghoff/nasmail/compare/v1.2.0...v1.3.0) (2026-06-16)


### Features

* add support for older Raspberry Pi ([0215d10](https://github.com/jabenninghoff/nasmail/commit/0215d10fbbb78ed015a104ab719b590c7b284c5f))
* bump alpine from 3.24.0 to 3.24.1 ([393b86a](https://github.com/jabenninghoff/nasmail/commit/393b86af731a91a633c143e367fb00dfef91634d))


### Bug Fixes

* update snapshots for alpine 3.24.0 ([212f5ec](https://github.com/jabenninghoff/nasmail/commit/212f5ec21dfad55b0d571ba0602a509c4c3342c0))

## [1.2.0](https://github.com/jabenninghoff/nasmail/compare/v1.1.6...v1.2.0) (2026-06-10)


### Features

* bump alpine from 3.23.4 to 3.24.0 ([130ca39](https://github.com/jabenninghoff/nasmail/commit/130ca393bc63c9b01ea1df42af326a667d25fb8a))


### Bug Fixes

* bump actions/checkout from 6.0.2 to 6.0.3 ([5be0701](https://github.com/jabenninghoff/nasmail/commit/5be07018c04e307e83312e24b9ff4e32ca325ae8))
* update snapshots for alpine 3.24.0 ([1ea0f8a](https://github.com/jabenninghoff/nasmail/commit/1ea0f8aec5ae55d79c873ace32df8d6eb6ffb5bd))

## [1.1.6](https://github.com/jabenninghoff/nasmail/compare/v1.1.5...v1.1.6) (2026-06-10)


### Bug Fixes

* add docker image digests ([1de5abb](https://github.com/jabenninghoff/nasmail/commit/1de5abb483931064e80922cc03511ab5d78a15c4))
* only publish releases to ghcr.io ([ae12703](https://github.com/jabenninghoff/nasmail/commit/ae12703bdf31b1455205f62d5c8a17f84c136afe))

## [1.1.5](https://github.com/jabenninghoff/nasmail/compare/v1.1.4...v1.1.5) (2026-06-10)


### Bug Fixes

* adopt alpine-docker mage conventions ([089482c](https://github.com/jabenninghoff/nasmail/commit/089482cb7cb74bf7600d2749c344292b3e4b29d9))
* bump docker/build-push-action from 7.1.0 to 7.2.0 ([1b4cbb8](https://github.com/jabenninghoff/nasmail/commit/1b4cbb8f178bf9e6e572fbef7cdc1b0b85542634))
* bump docker/login-action from 4.1.0 to 4.2.0 ([dc425cd](https://github.com/jabenninghoff/nasmail/commit/dc425cd33dde74b2e7fadb1f11390b3e2c7a73ba))
* bump docker/metadata-action from 6.0.0 to 6.1.0 ([ede8ba1](https://github.com/jabenninghoff/nasmail/commit/ede8ba1e4922d5dd65eadaba21f89afd14628347))
* bump docker/setup-buildx-action from 4.0.0 to 4.1.0 ([fe3631b](https://github.com/jabenninghoff/nasmail/commit/fe3631b5d5546480133dba527643e4dbea5d9a4a))
* hardcode default branch ([c416d43](https://github.com/jabenninghoff/nasmail/commit/c416d438bd3a594c50646934265b661a07096267))
* improve Publish Docker GitHub Action ([fdf079f](https://github.com/jabenninghoff/nasmail/commit/fdf079fe2817adebcd062c0ef3c090d2a416faeb))
* limit docker builds ([186bc15](https://github.com/jabenninghoff/nasmail/commit/186bc1555a01aafa6498a2fb8345fae9fc74bff6))
* update openssl from 3.5.6 to 3.5.7 ([1bb3e52](https://github.com/jabenninghoff/nasmail/commit/1bb3e528e1f7b88e19882982e7d2719f2edf1d93))

## [1.1.4](https://github.com/jabenninghoff/nasmail/compare/v1.1.3...v1.1.4) (2026-05-17)


### Bug Fixes

* upgrade postfix from 3.10.9 to 3.10.10 ([58e160a](https://github.com/jabenninghoff/nasmail/commit/58e160a95663fa57c07bf999e55ad890ee58e7c8))

## [1.1.3](https://github.com/jabenninghoff/nasmail/compare/v1.1.2...v1.1.3) (2026-05-06)


### Bug Fixes

* bump docker/build-push-action from 7.0.0 to 7.1.0 ([d5723cc](https://github.com/jabenninghoff/nasmail/commit/d5723ccfcf19d024c57c65ad0bb372777b1a7c40))
* bump googleapis/release-please-action from 4.4.1 to 5.0.0 ([952c774](https://github.com/jabenninghoff/nasmail/commit/952c774af7be19459bf454d80b0206e94a6a6d61))
* upgrade postfix from 3.10.8 to 3.10.9 ([cc9507f](https://github.com/jabenninghoff/nasmail/commit/cc9507fceb453b29541018fe4711ca77f8762319))

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
