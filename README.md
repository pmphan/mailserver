# Personal Mailserver

## Description

Mailserver running on Alpine Docker image. Because it's intended for personal use, right now it's mainly configured with one user in mind.

## Components

* Postfix
* OpenDKIM

## Installation

### Prequisite

* [Docker](https://docs.docker.com/engine/install/)
* [Docker Compose](https://docs.docker.com/compose/install/) _(optional, but makes things easier)_
* Certified TLS certificate from a CA. Certificate renew service is not Dockerized by choice.

### Build & Run

1. Clone this repository

```bash
git clone https://github.com/cupracer/mailserver.git /opt/docker/compose/mail
```

2. Create an `.env` with all variables:

```bash
# FQDN of mailserver
HOSTNAME=mail.example.com

# System user on Postfix
MASTER_USER=admin

# Randomize if not set
MASTER_PASS=secret

# Virtual user whose mail is redirected to/from MASTER_USER
# Currently not supporting more dynamic user mapping
VIRTUAL_USER=admin@mail.example.com

# List of client whose connection will be logged with more verbosity. Useful for debugging.
DEBUG_PEER_LIST=127.0.0.1

# Relay host. If configured, DKIM is not needed
RELAY_HOST=[smtp.relay.com]:587

# Username to authenticate with relay host
RELAY_USERNAME=username

# Password to authenticate with relay host
RELAY_PASSWORD=secret

# Selector for DKIM record
DKIM_SELECTOR=selector
```

Further config can be changed by modifying the compose file.

* `cert_file` location can be modified by changing the path after `file:` in `secrets:cert_file`
* `key_file` location can be modified by changing the path after `file:` in `secrets:key_file:`
* Change location in which OpenDKIM looks for key by changing `/etc/dkim/keys:/etc/dkim/keys` to `/path/to/keydir:/etc/dkim/keys`.

3. Start project:

```bash
docker-compose up -d
```

## Usage

Pre-built images are at [pmphan/mailserver-postfix](https://hub.docker.com/r/pmphan/mailserver-postfix/) and [pmphan/mailserver-opendkim](https://hub.docker.com/r/pmphan/mailserver-postfix/).

Mailserver is configured at: `mail.phuongmphan.com`

Mailserver is configured to permit mail originating from local network and Docker's host machine. Relay service required as VPS providers/ISPs block outbound port 25 and I don't have a static IP.

## Todo List

* configure on an actually testable environment.
* add back imap client
* Edit CI pipelines to populate docker-compose with env vars using envsub action (ssh-action does not support env vars) - (alternatively don't use compose just use docker up).
* edit CI pipelines to use same action for building and pushing images
