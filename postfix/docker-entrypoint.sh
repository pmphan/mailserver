#!/usr/bin/env bash
#
# Run setup and start Postfix.

# Add aliases
. ./scripts/helper.sh
. ./scripts/users.sh
. ./scripts/network.sh
. ./scripts/fillargs.sh

_add_master_user
_allow_docker
_substitute_pgsql_creds
_add_debug_peer_list
_config_relay_host

# Initialize aliases database.
newaliases

exec "$@"
