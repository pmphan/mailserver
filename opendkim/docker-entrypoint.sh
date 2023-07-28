#!/usr/bin/env bash
#
# Start container

/etc/opendkim/setup.sh

chown -R  opendkim:opendkim /etc/dkim/keys

exec "$@"
