#!/bin/bash

cd "$(dirname "$0")" || exit 1

file=$(ls *MaRViN* 2>/dev/null)
content=$(cat "$file")

[ "$content" == "42" ] && echo "✅ content OK" || echo "❌ content KO (got: $content)"
