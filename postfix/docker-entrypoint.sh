#!/usr/bin/env bash
#
# Run setup and start Postfix.

# Add aliases
. ./scripts/helper.sh
. ./scripts/aliases.sh
. ./scripts/network.sh

_add_master_user
_add_virtual_user
_allow_docker

# Initialize aliases database.
newaliases

# Start Postfix in foreground.
/usr/sbin/postfix start-fg
