#!/bin/bash

cd "$(dirname "$0")" || exit 1

oracle() {
	python3 -c '
import sys

alpha1 = ["\x27", "\x5c", "\"", "?", "!"]
alpha2 = list("mrdoc")
out = list("gtaio luSnemf")

def decode(s, alpha):
	n = 0
	for c in s:
		n = n * len(alpha) + alpha.index(c)
	return n

def encode(n, alpha):
	if n == 0:
		return alpha[0]
	digits = []
	base = len(alpha)
	while n > 0:
		digits.append(alpha[n % base])
		n //= base
	return "".join(reversed(digits))

a, b = sys.argv[1], sys.argv[2]
total = decode(a, alpha1) + decode(b, alpha2)
print(encode(total, out), end="")
' "$1" "$2"
}

check() {
	local a="$1" b="$2"
	expected=$(oracle "$a" "$b")
	got=$(FT_NBR1="$a" FT_NBR2="$b" bash add_chelou.sh)

	[ "$got" == "$expected" ] \
		&& echo "✅ FT_NBR1=$a FT_NBR2=$b -> $got" \
		|| echo "❌ FT_NBR1=$a FT_NBR2=$b -> got '$got', expected '$expected'"
}

check '!?' 'rd'
check "$(printf "'\\\\")" 'm'
check "$(printf '\\"?!')" 'odcmr'
check '????' 'ccccc'
