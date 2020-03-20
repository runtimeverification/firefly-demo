#!/usr/bin/env bash

set -euo pipefail

export FIREFLY_TOKEN="dkJaR203YzV2N2NpNmlaNHN6MGJ5UmtYaW42clFxYnBaTVZhQzJ2SUJTND0="

export KEVM_DIR=$(pwd)/firefly/deps/evm-semantics
export KEVM_DEFN_DIR=$(pwd)/firefly/.build/defn/coverage
export DEMOS_DIR=$(pwd)/tests
export PATH=$(pwd)/firefly:$PATH
export SHA=$(git rev-parse HEAD)

firefly prep tests/HelloWorld
firefly launch tests/HelloWorld 8145
firefly test tests/HelloWorld 8145

cd tests/HelloWorld
curl -X POST -f                                                 \
     -F access-token="$FIREFLY_TOKEN"                           \
     -F commit="github://runtimeverification/firefly-demo/$SHA" \
     -F 'status=pass'                                           \
     -F 'tag="hello world"'                                     \
     -F 'file=@report.txt'                                      \
     -F 'file2=@coverage_data.zip'                              \
     -F 'file3=@compiled.zip'                                   \
     'https://pr-37.sandbox.fireflyblockchain.com/report'
