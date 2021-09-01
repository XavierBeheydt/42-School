#!/bin/bash

cd "$(dirname "$0")" || exit 1

ls -lRa *MaRV* | cat -e

expected_name=$'"\\?$*\'MaRViN\'*$?\\"'
actual_name=$(find . -maxdepth 1 -name '*MaRViN*' -printf '%f')
content=$(cat -- "$actual_name")

[ "$actual_name" == "$expected_name" ] && echo "✅ filename is exact" || echo "❌ filename KO (got: $actual_name)"
[ "$content" == "42" ] && echo "✅ content is exactly 42" || echo "❌ content KO (got: $content)"
