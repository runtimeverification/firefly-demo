#!/usr/bin/env bash

set -euo pipefail

export FIREFLY_TOKEN="dmUwcVRISlEyY2tFUnl4MVJQcDZLWU5BNjRxYis3OW43anlOOE43MW5kaz0="

# contact Web API and download runner
curl http://firefly-test.cvlad.info/script?firefly_token="$FIREFLY_TOKEN" | sh

#launch kevm server
cd build/evm-semantics
PORT=8545
./kevm web3-ganache "$PORT" --shutdownable &
kevm_client_pid="$!"

#run ERC20Detailed.test.js through truffle
cd ../openzeppelin-contracts
while (! netcat -z 127.0.0.1 "$PORT") ; do sleep 0.1; done
node_modules/.bin/truffle test test/token/ERC20/ERC20Detailed.test.js &> ../report.txt
cd ..

#grab coverage data
cd evm-semantics
./kevm web3-send "$PORT" 'firefly_getCoverageData' > ../coverage.json

#close kevm
./kevm web3-send "$PORT" 'firefly_shutdown'
echo
timeout 8 tail --pid="$kevm_client_pid" -f /dev/null || true
pkill -P "$kevm_client_pid" kevm-client              || true
timeout 8 tail --pid="$kevm_client_pid" -f /dev/null || true
cd ..