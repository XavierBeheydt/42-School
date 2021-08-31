#!/bin/bash

export LC_ALL=C
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SANDBOX="$SCRIPT_DIR/.midls_sandbox"

if [ ! -f "$SCRIPT_DIR/midLS" ]; then
	echo "❌ midLS file not found in $SCRIPT_DIR"
	exit 1
fi

rm -rf "$SANDBOX"
mkdir "$SANDBOX"
cp "$SCRIPT_DIR/midLS" "$SANDBOX/midLS"
cd "$SANDBOX" || exit 1

mkdir test0     && touch -t 06010900 test0
touch .test1    && touch -t 06010930 .test1
touch ..test2   && touch -t 06010945 ..test2
touch test3     && touch -t 06011000 test3
touch test4     && touch -t 06011100 test4
mkdir test6     && touch -t 06011200 test6

# TODO: double check the sort direction expected by the subject
# (currently assuming oldest -> most recently modified)
EXPECTED_LIST="midLS, test6/, test4, test3, test0/"

out=$(sh midLS)

cd "$SCRIPT_DIR" || exit 1
rm -rf "$SANDBOX"

[ "$out" == "$EXPECTED_LIST" ] && echo "✅ midLS output OK ($out)" || echo "❌ midLS output KO ($out, expected $EXPECTED_LIST)"
