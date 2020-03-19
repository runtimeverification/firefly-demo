#!/usr/bin/env bash

set -euo pipefail

export FIREFLY_TOKEN="U052ZEQvZjVpZ0lQbjd1R1NlNFJpZGNTbVppbVFFSng4RWhOclpaTVk2RT0="

export KEVM_DIR=$(pwd)/firefly/deps/evm-semantics
export KEVM_DEFN_DIR=$(pwd)/firefly/.build/defn/coverage
export DEMOS_DIR=$(pwd)/tests
export PATH=$(pwd)/firefly:$PATH

firefly prep tests/HelloWorld
firefly launch tests/HelloWorld 8145
firefly test tests/HelloWorld 8145
