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
git clone 'https://github.com/openzeppelin/openzeppelin-solidity'
cd openzeppelin-solidity
git checkout 49042f2b1ae76eb9befa12000b98211981a139ec
npm install
node_modules/.bin/truffle compile
cd ..

#launch kevm server
PORT=8545
cd evm-semantics
./kevm web3-ganache "$PORT"
kevm_client_pid="$!"
while (! netcat -z 127.0.0.1 "$PORT") ; do sleep 0.1; done
cd ..

#run ERC20Detailed.test.js through truffle
cd openzeppelin-contracts
node_modules/.bin/truffle test test/token/ERC20/ERC20Detailed.test.js &> ../report.txt
cd ..

# post the report
curl -X POST -F 'access-token="jwC5UPsxlne4dwn4hnMIAhP605IghavpD+6UOmgSL7E="' -F 'status=pass' -F 'file=@report.txt' http://firefly-test-cvlad-info/report'

