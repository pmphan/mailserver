#!/usr/bin/env bash
#
# Add vmail user

function _add_vmail_user() {
  __add_system_user vmail -h /var/vmail --gecos "Vmail"
}

function __add_system_user() {
  # Add system user: username - password - GECOS
  # Check if user already exists.
  if id ${1} &> /dev/null
  then
    _log "warn" "User '${1}' already exists. Skip creating new user."
    return 1
  fi

  adduser ${1} --disabled-password -s /sbin/nologin ${@:2} && _log "info" "Added user '${1}'."
}
