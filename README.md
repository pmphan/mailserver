# Personal Mailserver

## Description

Personal mailserver running on Alpine Docker image.

## Installation

### Prequisite

* [Docker](https://docs.docker.com/engine/install/)
* [Docker Compose](https://docs.docker.com/compose/install/) _(optional)_

### Build & Run

1. Generate self-signed certificates:
```bash
./certs/gen-certs.sh
```

2. Build and run:
```bash
docker-compose up -d
```

## Usage

