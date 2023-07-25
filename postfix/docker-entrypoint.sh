#!/usr/bin/env bash
#
# Run setup and start Postfix.

# Add aliases
. ./scripts/helper.sh
. ./scripts/users.sh
. ./scripts/network.sh

_add_master_user
_add_vmail_user
_allow_docker
_add_debug_peer_list
_config_relay_host

# Initialize aliases database.
newaliases

# Start Postfix in foreground.
/usr/sbin/postfix start-fg
