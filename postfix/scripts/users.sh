#!/usr/bin/env bash
#
# Helper functions for configuring aliases.

function _add_master_user() {
  # Add admin email user whose root's emails will be routed to.
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

  local master_user="admin"
  __add_system_user ${master_user} --gecos "Master Email"

  : > /etc/postfix/aliases

  # Route root email to the master user account.
  echo "root: ${master_user}" >> /etc/postfix/aliases
  echo "${default_aliases}" >> /etc/postfix/aliases
  postalias /etc/postfix/aliases
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
