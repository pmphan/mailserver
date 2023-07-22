#!/usr/bin/env bash
#
# Configuring Postfix to recognize Docker subnet.

_allow_docker() {
  local docker_network=$(echo $(ip route) | awk -F ' ' '{printf $6}')
  _log "debug" "Add ${docker_network} to '\$mynetworks'."
  postconf "$(postconf mynetworks) ${docker_network}"
  _log "debug" "New $(postconf mynetworks)"
}
