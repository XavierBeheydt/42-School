#!/bin/bash

cd "$(dirname "$0")" || exit 1

python3 -c "print('0'*41 + '42', end='')" > .sample_ok
python3 -c "print('x'*50, end='')" > .sample_ko

out_ok=$(file -m ft_magic .sample_ok)
out_ko=$(file -m ft_magic .sample_ko)

echo "$out_ok" | grep -q "42 file" && echo "✅ 42 file detected" || echo "❌ 42 file not detected"
echo "$out_ko" | grep -q "42 file" && echo "❌ false positive on non-42 file" || echo "✅ non-42 file correctly not detected"

rm -f .sample_ok .sample_ko
