#!/usr/bin/env sh
#
# Substitute environment variable into DKIM config file startup.

sed -i "s/\$mydomain/${DKIM_DOMAIN:-localhost}/g" /etc/opendkim/opendkim.conf
sed -i "s/\$myselector/${DKIM_SELECTOR:-papaya}/g" /etc/opendkim/opendkim.conf

# Generate key if key not exist:
cd /etc/opendkim/keys
[[ ! -f {DKIM_DOMAIN}* ]] && opendkim-genkey -r -s ${DKIM_SELECTOR} -d ${DKIM_DOMAIN}
