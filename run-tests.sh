#!/usr/bin/env bash

set -e

notif () {
    echo "== $0: $@" 2>&1
}

run_single_test () {
    TEST_INPUT="$1"; shift
    EXPECTED_OUTPUT="$1"; shift

    # find a available port
    PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
    HOST=127.0.0.1

    # start client
    kevm-client -h "$HOST" -p "$PORT" --shutdownable 2>/dev/null &

    # wait for the client to start up
    while ! netcat -z "$HOST" "$PORT"; do sleep 0.1; done

    # send RPC call in *.in.json to kevm-client
    RESULT=$(cat "$TEST_INPUT" | netcat "$HOST" "$PORT" -q 0)

    # shutdown kevm-client
    printf '{"jsonrpc":"2.0","id":1,"method":"firefly_shutdown","params":[]}' | netcat "$HOST" "$PORT" > /dev/null

    # compare the result
    diff <(echo "$RESULT" | jq -cS .) <(jq -cS . "$EXPECTED_OUTPUT")
}

TEST_DIR="$1"
TEST_INPUT_ARRAY=($(find "$TEST_DIR" -maxdepth 1 -name *.in.json))

i=1
failed=0
success=0

for input in "${TEST_INPUT_ARRAY[@]}"; do
    # replace suffix
    expected="$(dirname $input)/$(basename $input | sed -n 's/\(.*\)\.in\.json/\1.expected.json/p')"
    
    notif "[$i/${#TEST_INPUT_ARRAY[@]}] $expected"

    if run_single_test $input $expected; then
        success=$((success+1))
    else
        failed=$((failed+1))
    fi

    i=$((i+1))
done

notif "succeeded $success"
notif "failed $failed"

[[ "$failed" == 0 ]]
