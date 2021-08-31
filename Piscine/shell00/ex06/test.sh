#!/bin/bash

cd "$(dirname "$0")" || exit 1

if [ ! -f git_ignore.sh ]; then
	echo "❌ git_ignore.sh not found"
	exit 1
fi

SANDBOX=$(mktemp -d)
cp git_ignore.sh "$SANDBOX/git_ignore.sh"

(
	cd "$SANDBOX" || exit 1
	git init -q

	printf '.DS_Store\n*~\n' > .gitignore
	touch .DS_Store mywork.c~ normal.txt README.md
	mkdir sub
	touch sub/.DS_Store sub/tracked.txt

	out=$(bash git_ignore.sh)

	check_present() {
		echo "$out" | grep -qx "$1" \
			&& echo "✅ $1 listed" \
			|| echo "❌ $1 missing from output"
	}
	check_absent() {
		echo "$out" | grep -qx "$1" \
			&& echo "❌ $1 should NOT be listed (it's not ignored)" \
			|| echo "✅ $1 correctly not listed"
	}

	check_present ".DS_Store"
	check_present "mywork.c~"
	check_present "sub/.DS_Store"
	check_absent "normal.txt"
	check_absent "README.md"
	check_absent "sub/tracked.txt"
	check_absent ".gitignore"

	lines=$(echo "$out" | grep -c .)
	[ "$lines" -eq 3 ] && echo "✅ exactly 3 ignored files reported" \
		|| echo "❌ expected 3 ignored files, got $lines"
)

rm -rf "$SANDBOX"
