# systemd-scripts

## Descriptions

This folder contains systemd service for auto updating Dynamic DNS for Google Domains and auto creation/renewal of certificates via Google DNS API.

## Installation

Copy all `service` and `timer` files to `/usr/lib/systemd/system/`.

```bash
sudo cp */*.service */*.timer /usr/bin/systemd/system/
```

Create a file at `/etc/ddns.conf` with variables for `ddns` service.

```bash
USERNAME=__api_auth_username__
PASSWORD=__api_auth_password__
HOSTNAME=thehostname.com
OFFLINE=[yes|no]
```

Create a file at `/etc/acme.conf` with variables for `acme` service.

```bash
RENEW_SCRIPT_PATH=/path/to/install-acme.sh
HOSTNAME=thehostname.com
HOMEDIR=/path/to/save/acme/client/installation
GOOGLEDOMAINS_ACCESS_TOKEN=__google_domain_access_token__
```

Enable/start `ddns` and `letsencrypt` timer or service.
