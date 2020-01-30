#!/usr/bin/env bash

set -euo pipefail

# Eventually this is how we'll do it, currently unused.
# contact Web API and download runner
# export FIREFLY_TOKEN="U052ZEQvZjVpZ0lQbjd1R1NlNFJpZGNTbVppbVFFSng4RWhOclpaTVk2RT0="
# curl https://sandbox.fireflyblockchain.com/script?firefly_token="$FIREFLY_TOKEN" | sh

curl --location --output k.tar.gz 'https://github.com/kframework/k/releases/download/v5.0.0-9985955/k-nightly.tar.gz'
tar --verbose --extract --file k.tar.gz
export K_RELEASE=$(pwd)/k

# install evm-semantics
git clone https://github.com/kframework/evm-semantics.git
cd evm-semantics
git submodule update --init --recursive -- deps/plugin
make build-web3
