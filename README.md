# nasmail

Lightweight container optimized for NAS hosted private or archived mail.

By design, the mail server only accepts email for configured users or aliases, and rejects relayed mail. It can be used to store an online archive of a retired email account, or as a private server for monitoring messages. It is intended to be deployed without a [MX record](https://en.wikipedia.org/wiki/MX_record) - instead, clients connect directly to send mail. Using a non-standard port will additionally reduce the chance of spam.

Inspired by [ServerContainers/minimail](https://github.com/ServerContainers/minimail).

## Docker Image

nasmail uses GitHub Actions to build and publish a Docker image to the GitHub Container Registry, based on the official GitHub [Documentation](https://docs.github.com/en/packages/managing-github-packages-using-github-actions-workflows/publishing-and-installing-a-package-with-github-actions), with updated dependencies and help from a helpful DEV [article](https://dev.to/natilou/automating-tag-creation-release-and-docker-image-publishing-with-github-actions-49jg) and [alpine-docker](https://github.com/alpine-docker). The included `compose.yaml` file can be adapted to deploy the container using `docker compose`.

Pull the latest (stable) image using:

```sh
docker pull ghcr.io/jabenninghoff/nasmail
```

New images are published for each new release only; there are no development images (`edge` or `main`). All pull requests and merges to main build and load the image (without publishing) for testing and validation. Images are built for Intel (`amd64`), 64-bit ARM (`arm64`: Apple, Raspberry Pi) and 32-bit ARM (`arm/v6`, `arm/v7`: older Raspberry Pi hardware).

Make sure to update the `image` section of the `compose.yaml`, a complete production file should resemble:

```yaml
services:
  nasmail:
    image: ghcr.io/jabenninghoff/nasmail:<version>
    restart: unless-stopped
    ports:
      - "25:25" # SMTP
      - "143:143" # IMAP
      - "587:587" # Submission
      - "993:993" # IMAPS
    volumes:
      - /usr/syno/etc/certificate/_archive/<directory>:/opt/nasmail/tls:ro
      - /full/path/to/users:/opt/nasmail/users:ro
      - /full/path/to/vmail:/var/vmail
    environment:
      - MAIL_HOST=mail.nasmail.test
      - TLS_KEY=/opt/nasmail/tls/privkey.pem
      - TLS_CERT=/opt/nasmail/tls/fullchain.pem
```

## Environment Variables

- `MAIL_HOST`: fully qualified domain name, defaults to mail.nasmail.local
- `TLS_KEY`: path to private key, in PEM format
- `TLS_CERT`: path to public certificate, in PEM format

`TLS_KEY` and `TLS_CERT` must both be set to enable TLS. As the `docker-mailserver` [documentation](https://docker-mailserver.github.io/docker-mailserver/latest/config/security/ssl/#example-using-lets-encrypt-certificates-with-a-synology-nas) notes, Synology NAS generated Let's Encrypt certificates are added with a random directory name under `/usr/syno/etc/certificate/_archive/`. Identify the correct directory name and add the following to `compose.yaml`:

```yaml
volumes:
  - /usr/syno/etc/certificate/_archive/<directory>:/opt/nasmail/tls:ro
environment:
  - TLS_KEY=/opt/nasmail/tls/privkey.pem
  - TLS_CERT=/opt/nasmail/tls/fullchain.pem
```

## Users

Users are defined in `/opt/nasmail/users/nasmail-users`, using the [passwd](https://doc.dovecot.org/2.4.3/core/config/auth/databases/passwd_file.html) file format, using the following format:

```passwd
nasmail@nasmail.local:{BLF-CRYPT}$2y$05$hTm9v3j7tLLwKpbpwwCXTOMYwTdmFaARo7MLzXuTrjACToEJ9999y:::postmaster@nasmail.local abuse@nasmail.local:
```

Use `doveadm pw -s BLF-CRYPT` to create the encrypted password using Blowfish. The first field contains the email address of the virtual user, the second contains the password, fields 3-4 (uid,gid) are blank, and field 5 (gecos) contains a list of aliases, including the domain name. The postfix `vmailbox` and `virtual` (alias) files are dynamically built from `nasmail-users` on launch.

The email address or alias `postmaster` must be set for each domain - if it is not, nasmail will automatically assign the alias to the first email in the file for that domain.

## Postfix

Postfix uses a configuration based on minimail, with help from [Ubuntu](https://documentation.ubuntu.com/server/how-to/mail-services/install-postfix/) and [Arch](https://wiki.archlinux.org/title/Virtual_user_mail_system_with_Postfix,_Dovecot_and_Roundcube) documentation for integration with Dovecot.

The static configuration enables Dovecot SASL authentication, directs mail logs to standard output (customary on Docker), disables local mail, enables virtual mail (and aliases) using Dovecot, and adds a [MSA](https://en.wikipedia.org/wiki/Message_submission_agent) on port 587.

The docker entrypoint script sets the Postfix hostname (FQDN), parses `nasmail-users` to create virtual users, aliases, and domains, and configures TLS if `TLS_KEY` and `TLS_CERT` are set. If using TLS, the script requires TLS encryption for SASL authentication and the MSA.

The image exports SMTP (25) and submission (587), and the volumes `/opt/nasmail/tls` (for certificates) and `/opt/nasmail/users` (for users).

## Dovecot

Dovecot 2.4 introduced breaking [changes](https://doc.dovecot.org/2.4.3/installation/upgrade/2.3-to-2.4.html) in the configuration format. The Dovecot configuration is built from the official [Quick Configuration](https://doc.dovecot.org/2.4.3/core/config/quick.html) and [Docker image](https://github.com/dovecot/docker/tree/main/2.4.3), using the minimail configuration as a reference. To simplify the configuration, a single file, `dovecot.conf` is used.

The static configuration directs logs to standard output and standard error, sets standard mailboxes (Drafts, Junk, Sent, Trash), configures `/var/vmail` for mail storage using the Maildir format, enables SASL authentication, and mail delivery using LMTP.

The docker entrypoint script sets the Dovecot postmaster address to the first postmaster email address or alias from the user file, and configures TLS if `TLS_KEY` and `TLS_CERT` are set.

The image exports IMAP (143) and IMAPS (993), and the volume `/var/vmail` (for mail storage).

## runit

nasmail uses [runit](https://smarden.org/runit/) to manage Postfix and Dovecot as system services.

## Automation

nasmail uses [conventional commits](https://www.conventionalcommits.org) and the [Release Please Action](https://github.com/googleapis/release-please-action) to automatically generate release notes (in `CHANGELOG.md`) and releases, with versions stored in `version.txt`. `version.txt` is manually updated by adding a `-dev` suffix when starting development on a new version; Release Please automatically updates the file when tagging a release.

nasmail is configured to update the base alpine Docker image and all GitHub Actions in `dependabot.yml`. All OS ([Alpine Linux](https://alpinelinux.org)) updates are treated as features, (`feat:`) and all GitHub Actions updates are treated as fixes (`fix:`). A separate job, `apk-upgrades.yaml`, checks for updated Alpine packages weekly and on-demand and sends an email alert if updates are available through job failure notification.

## Tests

nasmail has two test suites:

`image-tests.sh` runs the following tests, which require a locally built docker image using `docker-build.sh`:

- `apk-list.sh`: errors if installed `apk` packages have changed
- `postconf-defaults.sh`: errors if the postconf default configuration has changed
- `postconf.sh`: errors if the postconf static configuration (from Dockerfile) has changed
- `startup.sh`: starts a nasmail container and immediately exits
- `docker-header.sh`: places the Dockerfile version header on the clipboard
- `apk-upgrade.sh`: errors if updated `apk` packages are available

After the image tests pass, the version header can be pasted in the `Dockerfile` (for changes).

`live-tests.sh` runs the following tests, which additionally require a working Docker Compose environment, including valid `MAIL_HOST`, TLS configuration, `users` file (`nasmail-users`), and a `vmail` directory:

- `mail-recipients.sh`: validates server options, TLS configuration, and verifies that Postfix accepts mail for defined virtual users and aliases only

Manual testing of Dovecot is conducted using `compose.yaml` and [Thunderbird](https://www.thunderbird.net).

The full Docker Compose test environment uses dnsmasq to redirect `.local` to localhost (127.0.0.1), and a trusted self-signed certificate generated using macOS Keychain Access.
