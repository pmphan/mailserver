#!/usr/bin/env sh
#
# Substitute environment variable into DKIM config file startup.


# HELPER LOG FUNCTION.
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

# Expand vairables in config files
#
function expand_config() {
  if [[ -z $DKIM_DOMAIN ]]
  then
    _log "error" "'DKIM_DOMAIN' environment variable not found. Default to localhost."
  fi

  if [[ -z $DKIM_SELECTOR ]]
  then
    _log "info" "'DKIM_SELECTOR' environment variable not found. Default to papaya."
  fi

  sed -i "s/\$mydomain/${DKIM_DOMAIN:-localhost}/g" /etc/opendkim/opendkim.conf
  sed -i "s/\$myselector/${DKIM_SELECTOR:-papaya}/g" /etc/opendkim/opendkim.conf
}

function gen_key_pair() {
  # Generate keys for signing if key not exist:
  cd /etc/opendkim/keys
  if [[ ! -f ${DKIM_SELECTOR}* ]]
  then
    _log "info" "No key pair of '${DKIM_SELECTOR}' selector exists. Generating..."
    opendkim-genkey -r -s ${DKIM_SELECTOR} -d ${DKIM_DOMAIN}
  else
    _log "info" "Key pair of '${DKIM_SELECTOR}' exists. Skipping..."
  fi
}

expand_config
gen_key_pair
