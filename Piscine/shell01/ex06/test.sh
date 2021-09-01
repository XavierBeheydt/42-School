#!/bin/bash

cd "$(dirname "$0")" || exit 1

SANDBOX=$(mktemp -d)
cp skip.sh "$SANDBOX/skip.sh"

(
	cd "$SANDBOX" || exit 1
	touch file{1,2,3,4,5,6,7}

	full=$(ls -l)
	line1=$(echo "$full" | sed -n '1p')
	line3=$(echo "$full" | sed -n '3p')
	line5=$(echo "$full" | sed -n '5p')
	line7=$(echo "$full" | sed -n '7p')
	line9=$(echo "$full" | sed -n '9p')
	expected="$line1
$line3
$line5
$line7
$line9"

	result=$(bash skip.sh)

	[ "$result" == "$expected" ] && echo "✅ skip.sh OK" || echo "❌ skip.sh KO"
)

rm -rf "$SANDBOX"
