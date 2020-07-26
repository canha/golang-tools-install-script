#!/bin/bash
set -e
GOVER=$(go version)

echo "Testing to make sure that Go $REQVER is installed"

if grep -q "$REQVER" <<< "$GOVER"; then
	echo "Version contains: $REQVER"
	exit 0
else
	echo "Does not contain: $REQVER"
	exit 1
fi
