#!/usr/bin/env bash
#
# Entry point - fill args

. ./scripts/fillargs.sh
. ./scripts/helper.sh
. ./scripts/users.sh

_add_vmail_user
_substitute_pgsql_creds

exec "$@"
