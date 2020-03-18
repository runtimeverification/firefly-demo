#!/usr/bin/env bash

set -euo pipefail

export FIREFLY_TOKEN="U052ZEQvZjVpZ0lQbjd1R1NlNFJpZGNTbVppbVFFSng4RWhOclpaTVk2RT0="

cd firefly
./firefly prep ../tests/HelloWorld
./firefly launch ../tests/HelloWorld 8145
./firefly test ../tests/HelloWorld 8145
