#!/usr/bin/env bash
#
# Fill in config file pgsql credentials.

function _substitute_pgsql_creds() {
  _replace "\$dbuser" ${POSTGRES_USER}
  _replace "\$dbpassword" ${POSTGRES_PASSWORD}
  _replace "\$dbname" ${POSTGRES_DB}
}

function _replace() {
  sed -i "s/${1}/${2}/g" /etc/dovecot/dovecot-sql.conf.ext && _log "debug" "Subsituted ${1} /etc/postfix/pgsql/"
}
