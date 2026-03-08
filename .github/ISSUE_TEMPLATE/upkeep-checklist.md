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
- [ ] [Postfix](https://pkgs.alpinelinux.org/packages?name=postfix&branch=v3.23&repo=&arch=&origin=&flagged=&maintainer=)
- [ ] [Dovecot](https://pkgs.alpinelinux.org/packages?name=dovecot&branch=v3.23&repo=&arch=&origin=&flagged=&maintainer=)
- [ ] [Dovecot LMTP](https://pkgs.alpinelinux.org/packages?name=dovecot-lmtpd&branch=v3.23&repo=&arch=&origin=&flagged=&maintainer=)
- [ ] [runit](https://pkgs.alpinelinux.org/packages?name=runit&branch=v3.23&repo=&arch=&origin=&flagged=&maintainer=)

New versions use `feat:`, bug fixes and security updates use `fix:`. Note [breaking changes](https://www.conventionalcommits.org).

### GitHub Actions

Update GitHub Actions:

- [ ] [release-please](https://github.com/googleapis/release-please-action/)
- [ ] [checkout](https://github.com/actions/checkout/)
- [ ] [docker/login](https://github.com/docker/login-action/)
- [ ] [docker/metadata](https://www.github.com/docker/metadata-action/)
- [ ] [docker/setup-buildx](https://github.com/docker/setup-buildx-action/)
- [ ] [docker/build-push](https://github.com/docker/build-push-action/)
- [ ] [attest-build-provenance](https://github.com/actions/attest-build-provenance/)

### Docker

- [ ] Review Docker [release notes](https://docs.docker.com/engine/release-notes/) for changes

### Tests

Run tests:

- [ ] `postconf-defaults.sh`
- [ ] `postconf.sh`
- [ ] `recipients.sh`
