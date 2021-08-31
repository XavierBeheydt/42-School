#!/bin/bash

cd "$(dirname "$0")" || exit 1

out=$(bash git_commit.sh)
lines=$(echo "$out" | wc -l)

[ "$lines" -eq 5 ] && echo "✅ 5 lines OK" || echo "❌ expected 5 lines, got $lines"

echo "$out" | grep -Eq '^[0-9a-f]{40}$' && echo "✅ format looks like full commit hashes" \
	|| echo "❌ output does not look like full commit hashes"

echo "$out" | while read -r line; do
	echo "$line" | grep -Eq '^[0-9a-f]{40}$' \
		&& echo "  ✅ $line" \
		|| echo "  ❌ $line (not a 40-char hex hash)"
done
