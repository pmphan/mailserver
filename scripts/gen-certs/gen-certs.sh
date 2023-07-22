#!/usr/bin/env bash
#
# Generate self-signed certificate.

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat << EOF
Usage: $(basename "${BASH_SOURCE[0]}") [OPTIONS]

Generate self-signed certificates. Info is hardcoded.

Available options:

-h,  --help             Print this help message
-i,  --info             Print info after generation is finished
-kn, --keyname=FILE     Key file name
-cn, --crtname=FILE     Cert file name
EOF
  exit
}

# Exit with message
die() {
  echo "$*" 1>&2
  exit 1
}

gen_certs() {
  # Generate a self signed cert with hardcoded info.
  # $1 is path of output key file.
  # $2 is path of cert key file.
  openssl req -nodes \
              -x509 \
              -sha256 \
              -newkey rsa:4096 \
              -days 3650 \
              -keyout $1 \
              -out $2 \
              -subj "/C=US/ST=CA/L=Santa Ana/O=Phuong M Phan/OU=email/CN=phuongmphan.com"
}

# Print info of given certificate to verify.
print_cert_info() {
  openssl x509 -in $1 -text
}

parse_params() {
  # Default values for saved directory and filenames.
  keyname=${script_dir}/mail.key
  crtname=${script_dir}/mail.crt
  info=0

  while :; do
    case "${1-}" in
    -h  | --help) usage ;;
    -i  | --info) info=1 ;;
    -kn | --keyname)
      keyname=${2-}
      shift
    ;;
    -cn | --crtname)
      crtname=${2-}
      shift
    ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done
  return 0
}

parse_params "$@"
gen_certs "${keyname}" "${crtname}"
[[ $info -eq 1 ]] && print_cert_info "${crtname}"
