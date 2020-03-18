#!/usr/bin/env bash

set -euo pipefail

# Eventually this is how we'll do it, currently unused.
# contact Web API and download runner
# export FIREFLY_TOKEN="U052ZEQvZjVpZ0lQbjd1R1NlNFJpZGNTbVppbVFFSng4RWhOclpaTVk2RT0="
# curl https://sandbox.fireflyblockchain.com/script?firefly_token="$FIREFLY_TOKEN" | sh

# install firefly
cd firefly
git submodule update --init deps/evm-semantics
pushd deps/evm-semantics
git submodule init
git submodule deinit tests/ethereum-tests
git submodule update --recursive
cd deps/k
get submodule update --init --recursive
popd
pushd deps/evm-semantics/deps/k
mvn package -U -DskipTests -Dhaskell.backend.skip -Dproject.build.type=FastBuild
popd
make build-coverage-web3
