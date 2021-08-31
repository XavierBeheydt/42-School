#!/bin/bash

# Create a file called `z` that returns `Z`, followed by new line, whenever the command `cat` is used on it.

cd "$(dirname "$0")" || exit 1

rm -f z

echo "Z" > z
test -f "z" && echo "✅ \`z\` file exists!" || echo "❌ \`z\` file not exists!"
printf "Z\n" | cmp -s - z && echo "✅ \`Z\\n\` value is OK!" || echo "❌ \`Z\\n\` value is KO!"
