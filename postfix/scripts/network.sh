#!/usr/bin/env bash
#
# Configuring Postfix to recognize Docker subnet.

__expand_postconf_vars() {
  _log "debug" "Add '${2}' to '\$${1}'."
  postconf "$(postconf ${1}) ${2}"
  _log "debug" "New $(postconf ${1})"
}

_allow_docker() {
  local docker_network=$(echo $(ip route) | awk -F ' ' '{printf $6}')
  __expand_postconf_vars "mynetworks" ${docker_network}
}

_add_debug_peer_list() {
  __expand_postconf_vars "debug_peer_list" ${DEBUG_PEER_LIST}
}

_config_relay_host() {
  __expand_postconf_vars "relayhost" ${RELAY_HOST}

  if [[ ( ! -z ${RELAY_HOST} ) && ( -z ${RELAY_USERNAME} || -z ${RELAY_PASSWORD} ) ]]
  then
    _log "warn" "Relay host added but missing username or password."
  fi
  postconf "$(postconf smtp_sasl_password_maps) static:${RELAY_USERNAME}:${RELAY_PASSWORD}"
  _log "info" "Mapping added. Only static password map supported at the moment."
}
