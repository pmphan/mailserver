#!/usr/bin/env bash
#
# Helper functions for configuring aliases.

# Set default master user to 'contact'.
[[ -z ${MASTER_USER} ]] && export MASTER_USER=contact

function _add_master_user() {
  local default_aliases="# System aliases
MAILER-DAEMON:	postmaster
postmaster:	root

# Pseudo accounts
bin:        root
daemon:     root
adm:        root
uucp:       root
ftp:        root
nobody:     root
postfix:    root

# Well-known aliases
abuse:		postmaster
decode:		root

# Local and virtual users"

  if [[ ${MASTER_USER} == "root" ]]
  then
    _log "error" "Don't use root as main email user."
    return 1
  fi

  __add_system_user "${MASTER_USER}" "${MASTER_PASS:=$(echo $RANDOM | md5sum)}" "Master Email"

  : > /etc/postfix/aliases

  # Route root email to the master user account.
  echo "root: ${MASTER_USER}" >> /etc/postfix/aliases
  echo "${default_aliases}" >> /etc/postfix/aliases

  postalias /etc/postfix/aliases
}

function _add_virtual_user() {
  # By default map virtual user to root
  if [[ -z ${VIRTUAL_USER} ]]
  then
    _log "debug" "Empty 'VIRTUAL_USER', no default virtual alias created."
    return 0
  fi

  : > /etc/postfix/virtual
  echo "${VIRTUAL_USER} ${MASTER_USER}" >> /etc/postfix/virtual
  postmap /etc/postfix/virtual
}

function __add_system_user() {
  # Add system user: username - password - GECOS
  # Check if user already exists.
  if id ${1} &> /dev/null
  then
    _log "warn" "User '${1}' already exists. Skip creating new user."
    return 1
  fi

  adduser ${1} --disabled-password --gecos ${3}
  _log "info" "Added user '${1}' as master user."
  _log "debug" echo ${1}:${2} | chpasswd
}
