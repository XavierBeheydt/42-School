#!/bin/bash

cd "$(dirname "$0")" || exit 1

SANDBOX=$(mktemp -d)
cp skip.sh "$SANDBOX/skip.sh"

(
	cd "$SANDBOX" || exit 1
	touch file{1,2,3,4,5,6,7}

	result=$(bash skip.sh)
	expected=$(ls -l | sed -n '1~2p')

	[ "$result" == "$expected" ] && echo "✅ skip.sh OK" || echo "❌ skip.sh KO"
)

rm -rf "$SANDBOX"
