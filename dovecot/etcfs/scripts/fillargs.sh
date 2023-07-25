#!/usr/bin/env bash
#
# Subsitute sql connect command with credentials environment arguments.

function _substitue_pgsql_creds() {
  __replace "\$dbuser" ${POSTGRES_USER}
  __replace "\$dbpassword" ${POSTGRES_PASSWORD}
  __replace "\$dbname" ${POSTGRES_DB}
}

function __replace() {
  sed -i "s/${1}/${2}/g" /etc/dovecot/dovecot-sql.conf.ext && _log "debug" "Subsituted ${1}."
}
