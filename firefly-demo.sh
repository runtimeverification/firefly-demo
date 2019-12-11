#!/usr/bin/env bash

set -euo pipefail

# contact Web API and download runner
curl http://firefly-test.cvlad.info/script?firefly_token="jwC5UPsxlne4dwn4hnMIAhP605IghavpD+6UOmgSL7E=" | sh

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
cd build
cd evm-semantics
./kevm web3-ganache "$PORT" --shutdownable &
kevm_client_pid="$!"
cd ..

#run ERC20Detailed.test.js through truffle
cd openzeppelin-contracts
while (! netcat -z 127.0.0.1 "$PORT") ; do sleep 0.1; done
node_modules/.bin/truffle test test/token/ERC20/ERC20Detailed.test.js &> ../report.txt
cd ..

#close kevm
cd evm-semantics
./kevm web3-send "$PORT" 'firefly_shutdown'
echo
timeout 8 tail --pid="$kevm_client_pid" -f /dev/null || true
pkill -P "$kevm_client_pid" kevm-client              || true
timeout 8 tail --pid="$kevm_client_pid" -f /dev/null || true
cd ..

# post the report
curl -X POST -F 'access-token="jwC5UPsxlne4dwn4hnMIAhP605IghavpD+6UOmgSL7E="' -F 'status=pass' -F 'file=@report.txt' http://firefly-test.cvlad.info/report

