#!/usr/bin/env bash
#
# Configuring Postfix to recognize Docker subnet.

_allow_docker() {
  local docker_network=$(echo $(ip route) | awk -F ' ' '{printf $6}')
  _log "debug" "Add ${docker_network} to '\$mynetworks'."
  postconf "$(postconf mynetworks) ${docker_network}"
  _log "debug" "New $(postconf mynetworks)"
}

_add_debug_peer_list() {
  _log "debug" "Adding ${DEBUG_PEER_LIST} into '\$debug_peer_list'."
  postconf "$(postconf debug_peer_list) ${DEBUG_PEER_LIST}"
  _log "debug" "New $(postconf debug_peer_list)"
}
