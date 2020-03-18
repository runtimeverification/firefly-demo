#!/usr/bin/env bash

set -euo pipefail

# Eventually this is how we'll do it, currently unused.
# contact Web API and download runner
# export FIREFLY_TOKEN="U052ZEQvZjVpZ0lQbjd1R1NlNFJpZGNTbVppbVFFSng4RWhOclpaTVk2RT0="
# curl https://sandbox.fireflyblockchain.com/script?firefly_token="$FIREFLY_TOKEN" | sh

# install firefly
git clone git@github.com:runtimeverification/firefly.git
cd firefly
git submodule update --init --recursive
make deps
make build-coverage-web3
