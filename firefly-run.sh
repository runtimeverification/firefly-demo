#!/usr/bin/env bash

set -euo pipefail

export FIREFLY_TOKEN="U052ZEQvZjVpZ0lQbjd1R1NlNFJpZGNTbVppbVFFSng4RWhOclpaTVk2RT0="

cd firefly
firefly prep tests/tools/random-testing/coverage
firefly launch tests/tools/random-testing/coverage 8540
firefly test tests/tools/random-testing/coverage 8540
