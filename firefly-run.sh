#!/usr/bin/env bash

set -euo pipefail

export FIREFLY_TOKEN="Yk5ac0ZtdkR3d1VWZ2diNDRadnhUc0h6UjJZZ2dmQ3Z5Mlh1U2JEbVNtUT0="

# install openzeppelin-contracts
git clone 'https://github.com/OpenZeppelin/openzeppelin-contracts'
cd openzeppelin-contracts
git checkout b8c8308d77beaa733104d1d66ec5f2962df81711
npm install
node_modules/.bin/truffle compile

# fetch compiled build data
zip ../compiled.zip -r build/
cd ..

# launch kevm server, wait for it to start
PORT=8545
cd evm-semantics
./kevm web3-ganache "$PORT" --shutdownable &
kevm_client_pid="$!"
cd ..
while (! netcat -z 127.0.0.1 "$PORT") ; do sleep 0.1; done

# run some tests through truffle
cd openzeppelin-contracts
node_modules/.bin/truffle test test/token/ERC20/ERC20Detailed.test.js &> ../report.txt
node_modules/.bin/truffle test test/token/ERC20/ERC20Mintable.test.js &>> ../report.txt
cd ..

# recover coverage data
cd evm-semantics
./kevm web3-send "$PORT" 'firefly_getCoverageData' &> ../coverage.json
cd ..

# close kevm (optional)
cd evm-semantics
./kevm web3-send "$PORT" 'firefly_shutdown'
cd ..

# post the reports

commit_short=$(git rev-parse HEAD)

curl -X POST -F access-token="$FIREFLY_TOKEN"                                        \
             -F 'commit=github://runtimeverification/firefly-demo/'$commit_short     \
             -F 'status=pass'                                                        \
             -F 'file=@report.txt'                                                   \
             -F 'file2=@coverage.json'                                               \
             -F 'file3=@compiled.zip' 'https://pr-34.sandbox.fireflyblockchain.com/report'