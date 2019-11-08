#!/usr/bin/env bash

set -euo pipefail

REPO_DIR=evm-semantics
INSTALL_PREFIX=/usr/local/bin

if ! [ -d "$REPO_DIR" ]; then
    git clone https://github.com/kframework/evm-semantics.git "$REPO_DIR"
fi

cd "$REPO_DIR"

make deps
make build-web3
make build-node

sudo cp .build/defn/vm/kevm-vm "$INSTALL_PREFIX/kevm-vm"
sudo cp .build/defn/web3/build/kevm-client "$INSTALL_PREFIX/kevm-client"
