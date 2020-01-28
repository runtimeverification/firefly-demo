## Authorize Github

 - Go to sandbox.fireflyblockchain.com
 - At the top right, click on "login"
 - At the Github OAuth screen, click on the "Authorize rv-jenkins" button

![](https://raw.githubusercontent.com/runtimeverification/firefly-demo/guy_doc/img/1authorize.png)

## Set up an access token

 - After being redirected, go to the "Products" drop-down in the top right and click on "test runner"

![](https://raw.githubusercontent.com/runtimeverification/firefly-demo/guy_doc/img/2testrunner.png)
 - Click on the "install now" button at the new page
 - Type in a name for your new token and click on "create"

![](https://raw.githubusercontent.com/runtimeverification/firefly-demo/guy_doc/img/3createtoken.png)
 - Save the token for later

## Set up CI

In your CI script, have a stage that does the following:

Install the Firefly client. The following dependencies must be installed for Ubuntu:
```
autoconf
bison
clang-8
cmake
flex
gcc
git
libboost-test-dev
libcrypto++-dev
libffi-dev
libgflags-dev
libjemalloc-dev
libmpfr-dev
libprocps-dev
libsecp256k1-dev
libssl-dev
libtool
libyaml-dev
lld-8
llvm-8-tools
make
maven
openjdk-11-jdk
pandoc
pkg-config
python3
rapidjson-dev
software-properties-common
zip
zlib1g-dev
```

```
git clone https://github.com/kframework/evm-semantics.git
cd evm-semantics
make deps
make build-web3
cd ..
```

Zip up your compiled Solidity contracts (They exist under the `build` directory in this example)
```
zip compiled.zip -r build/
```

Launch the Firefly client (we use port 8545 in this example)
```
cd evm-semantics
./kevm web3-ganache 8545 --shutdownable &
cd ..
```

Run the test suite that will talk to the Firefly client (ie. Truffle). Save the output.
```
truffle test &> results.txt
```

Retrieve the coverage data from Firefly and then close the client.
```
cd evm-semantics
./kevm web3-send 8545 firefly_getCoverageData &> ../coverage.json
./kevm web3-send 8545 firefly_shutdown
cd ..
```

Send the gathered data to the Firefly server
```
curl -X POST -F access-token="<YOUR_ACCESS_TOKEN>" -F 'status=pass' -F 'file=@report.txt' -F 'file2=@coverage.json' -F 'file3=@compiled.zip' https://sandbox.fireflyblockchain.com/report
```

## View the report
 - Go back to sandbox.fireflyblockchain.com
 - In the upper right corner click on "Dashboard"
 - You will be shown a list of reports that have come back from CI. You can click on "Coverage" to view the coverage report

![](https://raw.githubusercontent.com/runtimeverification/firefly-demo/guy_doc/img/4coverage.png)
