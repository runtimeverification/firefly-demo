#!/usr/bin/env bash

set -euo pipefail

export FIREFLY_TOKEN="FireflyDemoRepo17Jan"

# contact Web API and download runner
curl http://sandbox.fireflyblockchain.com/script?firefly_token="$FIREFLY_TOKEN" | sh

# install evm-semantics
mkdir build
cd build
git clone https://github.com/kframework/evm-semantics.git
cd evm-semantics
make deps
make build-web3
cd ..

# install openzeppelin-contracts
git clone 'https://github.com/OpenZeppelin/openzeppelin-contracts'
cd openzeppelin-contracts
git checkout 49042f2b1ae76eb9befa12000b98211981a139ec
npm install
node_modules/.bin/truffle compile
cd ..

#launch kevm server
PORT=8545
cd evm-semantics
./kevm web3-ganache "$PORT" --shutdownable &
kevm_client_pid="$!"
cd ..

#run ERC20Detailed.test.js through truffle
cd openzeppelin-contracts
while (! netcat -z 127.0.0.1 "$PORT") ; do sleep 0.1; done
node_modules/.bin/truffle test test/token/ERC20/ERC20Detailed.test.js &> ../report.txt
cd ..

#generate coverage data
cd evm-semantics
./kevm web3-send "$PORT" 'firefly_getCoverageData' &> ../coverage.json
cd ..

#close kevm
cd evm-semantics
./kevm web3-send "$PORT" 'firefly_shutdown'
echo
timeout 8 tail --pid="$kevm_client_pid" -f /dev/null || true
pkill -P "$kevm_client_pid" kevm-client              || true
timeout 8 tail --pid="$kevm_client_pid" -f /dev/null || true
cd ..

# post the reports
curl -X POST -F access-token="$FIREFLY_TOKEN" -F 'status=pass' -F 'file=@report.txt' -F 'file2=@coverage.json' http://sandbox.fireflyblockchain.com/report
