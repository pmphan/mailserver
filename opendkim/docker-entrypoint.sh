#!/usr/bin/env sh
#
# Start container

/etc/opendkim/setup.sh

/usr/sbin/opendkim -f -x /etc/opendkim/opendkim.conf
