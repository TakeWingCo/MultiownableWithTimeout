#!/usr/bin/env bash

set -u
set -e

TARGETS='	
./contracts/MultiownableWithTimeout.sol
./tests/contracts/SimpleStorage.sol
'

for SOLIDITY_FILE in $TARGETS
do
    echo compiling "$SOLIDITY_FILE"
#    TEMP="bin/`basename $SOLIDITY_FILE`"
    TEMP=temp.sol
    python3 scripts/solc_precompile.py "$SOLIDITY_FILE" > "$TEMP"
    solc --optimize-runs 200 --optimize --bin --abi --overwrite -o bin "$TEMP"
done

echo all contracts were compiled

