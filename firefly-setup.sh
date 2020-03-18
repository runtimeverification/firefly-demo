#!/usr/bin/env bash

set -euo pipefail

# Eventually this is how we'll do it, currently unused.
# contact Web API and download runner
# export FIREFLY_TOKEN="U052ZEQvZjVpZ0lQbjd1R1NlNFJpZGNTbVppbVFFSng4RWhOclpaTVk2RT0="
# curl https://sandbox.fireflyblockchain.com/script?firefly_token="$FIREFLY_TOKEN" | sh

# install firefly
cd firefly
git submodule update --init --recursive
pushd deps/evm-semantics/deps/k
mvn package -U -DskipTests -Dhaskell.backend.skip -Dproject.build.type=FastBuild
popd
make build-coverage-web3
