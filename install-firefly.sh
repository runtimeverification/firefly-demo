#!/usr/bin/env bash

set -ueo pipefail
shopt -s extglob

notif() {
    echo "== $0: $@" 2>&1
}

fatal() {
    notif "$@"
    exit 1
}

distro="$1" ; shift

download_url_base='https://github.com/kframework/evm-semantics/releases/download'
download_version='v1.0.0-3cecbb6'

case "$distro" in
    ubuntu-bionic ) download_pkg_name='kevm_1.0.0_amd64_bionic.deb' ;;
    debian-buster ) download_pkg_name='kevm_1.0.0_amd64_buster.deb' ;;
    *             ) fatal "Unknown distro: $distro"                 ;;
esac

download_url="$download_url_base/$download_version/$download_pkg_name"
notif "Downloading: $download_url"
curl --location --output "$download_pkg_name" "$download_url"

case "$distro" in
    @(ubuntu-bionic|debian-buster) ) sudo apt-get install --yes "./$download_pkg_name"
esac
