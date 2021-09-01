#!/bin/bash

cd "$(dirname "$0")" || exit 1

check_user() {
	local user="$1"
	expected=$(id -nG "$user" | awk '{gsub(/ /, ","); printf "%s", $0}')
	got=$(FT_USER="$user" bash print_groups.sh)

	if [ "$got" == "$expected" ]; then
		echo "✅ FT_USER=$user -> $got"
	else
		echo "❌ FT_USER=$user -> got '$got', expected '$expected'"
	fi

	echo "$got" | grep -q ' ' && echo "❌ output for $user contains a space" || echo "✅ no space in output for $user"
}

check_user "$(whoami)"
check_user "root"
id daemon > /dev/null 2>&1 && check_user "daemon"

out=$(FT_USER="$(whoami)" bash print_groups.sh | wc -l)
[ "$out" -eq 0 ] && echo "✅ no trailing newline" || echo "❌ output has a trailing newline"
