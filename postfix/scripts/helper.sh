#!/usr/bin/env bash
#
# Helper scripts.

# Set default log level to debug.
[[ -z ${LOG_LEVEL} ]] && export LOG_LEVEL=5

_log() {
  # Helper logging to stdout function.
  if [[ -z ${1} ]]
  then
    _log "error" "Call to _log() missing log level."
    return 1
  fi

  if [[ -z ${2} ]]
  then
    _log "error" "Call to _log() missing a message."
    return 1
  fi

  # Logging level requested by caller function.
  local req_level
  case "${1}" in
    "debug" )   req_level=5 ;;
    "info" )    req_level=4 ;;
    "warn" )    req_level=3 ;;
    "error" )   req_level=2 ;;
    "critical") req_level=1 ;;
    * )
      _log "warn" "Call to _log() with invalid log level '${1^^}'."
      return 1
    ;;
  esac

  # Do nothing if log level of message is higher than global log level.
  [[ ${req_level} -gt ${LOG_LEVEL} ]] && return 0 || echo "${1^^} - ${BASH_SOURCE[1]##*/}/${FUNCNAME[1]}: ${2}"
}
