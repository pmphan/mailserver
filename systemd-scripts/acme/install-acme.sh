#!/usr/bin/env bash
#
# Install acme.sh if not already exist.

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

install_acme() {
  [[ -z ${HOMEDIR} ]] && HOMEDIR=$script_dir
  mkdir -p ${HOMEDIR}/acme.git

  git clone --depth 1 https://github.com/acmesh-official/acme.sh.git ${HOMEDIR}/acme.git

  cd ${HOMEDIR}/acme.git
  # Install w/o crontab
  ${HOMEDIR}/acme.git/acme.sh --install --home ${HOMEDIR} --nocron
}

install_cert() {
  # Init cert with Google token
  ${HOMEDIR}/acme.sh --staging --debug --issue --dns dns_googledomains -d ${HOSTNAME} -d mail.${HOSTNAME}

  # Install cert
  ${HOMEDIR}/acme.sh --debug --install-cert -d ${HOSTNAME} -d mail.${HOSTNAME} \
                     --cert-file /etc/ssl/${HOSTNAME}.crt \
                     --key-file /etc/ssl/private/${HOSTNAME}.key \
                     --ca-file /etc/ssl/ca.crt \
                     --fullchain-file /etc/ssl/fullchain.crt
}

renew_cert() {
  ${HOMEDIR}/acme.sh --staging --debug --renew --force --dns dns_googledomains -d ${HOSTNAME} -d mail.${HOSTNAME}
}

source_env() {
  source ${HOMEDIR}/acme.sh.env
}

# Get ACME if not exist
if [[ ! -f ${HOMEDIR}/acme.sh ]]
then
  install_acme
  source_env
  install_cert
else
  source_env
  renew_cert
fi
