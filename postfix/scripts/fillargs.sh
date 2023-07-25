#!/usr/bin/env bash
#
# Subsitute postgres config files with environment arguments.

function _substitue_pgsql_creds() {
  __replace "\$dbuser" ${POSTGRES_USER}
  __replace "\$dbpassword" ${POSTGRES_PASSWORD}
  __replace "\$dbname" ${POSTGRES_DB}
}

function __replace() {
  sed -i "s/${1}/${2}/g" /etc/postfix/pgsql/*.cf && _log "debug" "Subsituted ${1} /etc/postfix/pgsql/"
}
