#!/usr/bin/env bash
#
# Start container

/etc/opendkim/setup.sh

chown -R  opendkim:opendkim /etc/dkim/keys

/usr/bin/supervisord -c /etc/supervisor.d/supervisord.conf
