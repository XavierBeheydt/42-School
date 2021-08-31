#!/bin/bash

# Structural check for b: it must exist, differ from a, and the diff
# between a and b must be a valid patch that turns a back into b.

cd "$(dirname "$0")" || exit 1

[ -f a ] && echo "✅ a exists" || { echo "❌ a missing"; exit 1; }
[ -f b ] && echo "✅ b exists" || { echo "❌ b missing"; exit 1; }

if diff -q a b > /dev/null; then
	echo "❌ b is identical to a (nothing was fixed)"
else
	echo "✅ b differs from a"
fi

SANDBOX=$(mktemp -d)
cp a "$SANDBOX/a"
diff a b > "$SANDBOX/sw.diff"

(
	cd "$SANDBOX" || exit 1
	patch -s a sw.diff
	if diff -q a "$OLDPWD/b" > /dev/null; then
		echo "✅ patch a < sw.diff reproduces b exactly"
	else
		echo "❌ patching a with the a/b diff does NOT reproduce b"
	fi
)

rm -rf "$SANDBOX"
