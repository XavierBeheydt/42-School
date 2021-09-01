#!/bin/bash

cd "$(dirname "$0")" || exit 1

oracle() {
	python3 -c '
import sys
lines = [l.rstrip("\n") for l in open("/etc/passwd") if not l.startswith("#")]
logins = [l.split(":")[0] for i, l in enumerate(lines, start=1) if i % 2 == 0]
logins = [l[::-1] for l in logins]
logins.sort(reverse=True)
a, b = int(sys.argv[1]), int(sys.argv[2])
selected = logins[a-1:b]
print(", ".join(selected) + ".", end="")
' "$1" "$2"
}

check_range() {
	local a="$1" b="$2"
	expected=$(oracle "$a" "$b")
	got=$(FT_LINE1="$a" FT_LINE2="$b" bash r_dwssap.sh)

	[ "$got" == "$expected" ] \
		&& echo "✅ FT_LINE1=$a FT_LINE2=$b OK" \
		|| echo "❌ FT_LINE1=$a FT_LINE2=$b KO (got: $got | expected: $expected)"
}

check_range 1 3
check_range 2 5
total=$(awk '!/^#/' /etc/passwd | awk 'NR % 2 == 0' | wc -l)
check_range 1 "$total"
