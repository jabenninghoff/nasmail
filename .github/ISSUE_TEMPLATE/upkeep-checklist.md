---
name: Upkeep Checklist
about: Periodic upkeep checklist
title: Upkeep (DATE)
labels: ''
assignees: ''

---

### OS and Packages

Update Alpine Linux and packages:

- [ ] [Alpine](https://alpinelinux.org/releases/) *(new release branch each May and November)*
- [ ] `./tests/apk-upgrade.sh`
- [ ] [Postfix](https://www.postfix.org/announcements.html)
- [ ] [Dovecot](https://github.com/dovecot/core/releases)
- [ ] [runit](https://github.com/g-pape/runit/releases)

New versions use `feat:`, bug fixes and security updates use `fix:`. Note [breaking changes](https://www.conventionalcommits.org).

### GitHub Actions

Update GitHub Actions:

- [ ] [release-please-action](https://github.com/googleapis/release-please-action/)
- [ ] [checkout](https://github.com/actions/checkout/)
- [ ] [docker/login-action](https://github.com/docker/login-action/)
- [ ] [docker/metadata-action](https://www.github.com/docker/metadata-action/)
- [ ] [docker/setup-buildx-action](https://github.com/docker/setup-buildx-action/)
- [ ] [docker/build-push-action](https://github.com/docker/build-push-action/)
- [ ] [attest-build-provenance](https://github.com/actions/attest-build-provenance/)

### Docker

- [ ] Review Docker [release notes](https://docs.docker.com/engine/release-notes/) for changes

### Tests

Run tests:

- [ ] `apk-list.sh`
- [ ] `postconf-defaults.sh`
- [ ] `postconf.sh`
- [ ] `recipients.sh`
